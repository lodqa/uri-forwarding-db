class UrlController < ApplicationController
  def translate
    # For debuging
    @query = params[:query]
    @matchers = JSON.pretty_generate Matcher.all.map(&:attributes)

    # Do replacement
    @result = Matcher.all
      .select{ |m| Regexp.compile(m.uri_pattern).match? @query }
      .map do |m|
        {
          name: m.name,
          url: @query.gsub(Regexp.compile(m.uri_pattern), m.url_replacement_pattern),
          priority: m.priority,
          matching_score: m.matching_score(@query)
        }
      end

    respond_to do |format|
      format.html { render :translate }
      format.json { render :translate }
      format.tsv { render :translate }
    end
  end
end
