class AppSweeper < ActionController::Caching::Sweeper
  observe Widget
  def after_create(record)
    expire_cache_for(record)
  end
  def after_update(record)
    expire_cache_for(record)
  end
  def after_destroy(record)
    expire_cache_for(record)
  end  
  private
  def expire_cache_for(record)
    expire_action(:controller => params[:controller], :action => 'index')
    #expire_action(:controller => params[:controller], :action => 'show', :id => record.id)
    expire_page(:controller => params[:controller], :action => 'show', :id => record.id)
  end
end