require './idea'
require './idea_store'

class IdeaBoxApp < Sinatra::Base
  set :method_override, true

  not_found do
    erb :error
  end

  get '/' do
    erb :index, locals: {ideas: IdeaStore.all, idea: Idea.new(params)}
  end

  post '/' do
    IdeaStore.create(params[:idea])
    # idea = Idea.new(params[:idea])
    # idea.save
    redirect '/'
  end

  delete '/:id' do |id|
    IdeaStore.delete(id.to_i)
    redirect '/'
  end

  get '/:id/edit' do |id|
    idea = IdeaStore.find(id.to_i)
    erb :edit, locals: {id: id, idea: idea}
  end

  put '/:id' do |id|
    IdeaStore.update(id.to_i, params[:idea])
    redirect '/'
  end

  configure :development do
    register Sinatra::Reloader
  end
end
