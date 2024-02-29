class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @model = params['model']
    @content = params['content']
    @method = params['method']
    @result = search_for(@model, @content, @method)
  end
  
  private
  
  def search_for(model, content, method)
    if model == 'book'
      if method == 'forward'
        Book.where(
          'title LIKE ? OR body LIKE ?',
          "#{content}%", "#{content}%"
          )
      elsif method == 'backward'
        Book.where(
          'title LIKE ? OR body LIKE ?',
          "%#{content}", "%#{content}"
          )
      elsif method == 'perfect'
        Book.where(
          'title LIKE ? OR body LIKE ?',
          "#{content}", "#{content}"
          )
      else #部分一致
        Book.where(
          'title LIKE ? OR body LIKE ?',
          "%#{content}%", "%#{content}%"
          )
      end
    elsif  model == 'user'
      if method == 'forward'
        User.where(
          'name LIKE ?',
          "#{content}%"
          )
      elsif method == 'backward'
        User.where(
          'name LIKE ?',
          "%#{content}"
          )
      elsif method == 'perfect'
        User.where(
          'name LIKE ?',
          "#{content}"
          )
      else #部分一致
        User.where(
          'name LIKE ?',
          "%#{content}%"
          )
      end    
    else
      []
    end
  end
  
end
