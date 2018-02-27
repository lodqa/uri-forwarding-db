class UrlController < ApplicationController
  def translate
    # For debuging
    @query = params[:query]
    @matchers = JSON.pretty_generate Matcher.all.map(&:attributes)

    @result = Matcher.replace @query

    respond_to do |format|
      format.html { render :translate }
      format.json { render :translate }
      format.tsv { render :translate }
    end
  end
end
