class PostCreateService
  def initialize(params)
    @post_params = params.slice(:title, :content)
    @author_params = params.slice(:author_login, :author_ip)
  end

  def perform
    author = User.where(login: @author_params[:login]).first_or_initialize
    post = Post.create(@post_params.merge())



    alarms = search_filter(alarms)
    alarms = alarms.filter_search(alarms, filter: { events: @raw_query }.to_json) if @raw_query
    alarms = alarms.where(events: { initiated_at: @time_constrain.minutes.ago..Time.zone.now }) if @time_constrain.positive?
    alarms
  end

  private

  def search_filter(scope)
    if @search.is_a?(String)
      query = SEARCH_FIELDS.values.map do |c|
        "#{c} ILIKE #{quote("%#{@search}%")}"
      end.join(' OR ')

      scope.where(query)
    elsif @search.is_a?(Hash)
      query = @search.map do |k, v|
        "#{SEARCH_FIELDS[k.to_sym]} ILIKE #{quote("%#{v}%")}"
      end.join(' OR ')

      scope.where(query)
    else
      scope
    end
  end

  def quote(str)
    ActiveRecord::Base.connection.quote(str)
  end
end
