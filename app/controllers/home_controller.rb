class HomeController < ApplicationController
	require 'open-uri'
	require 'nokogiri'
	require 'cgi'

  before_action :set_url_params, only: [:makerequest]
  def index
  	@makerequest = ''
  end
  def makerequest
  	respond_to do |format|
  		format.html{
  			doc = Nokogiri::HTML(open(set_url_params[:instaurl]))
  			if !(doc.blank?)
          @postData = Hash.new
          if (doc.at("meta[name='medium']")["content"] == "image")
            @postData[:author] = CGI.parse(URI.parse(set_url_params[:instaurl]).query)["taken-by"].join
            @postData[:imgUrl] = doc.at("meta[property='og:image']")["content"]
            @postData[:link] = doc.at("meta[property='og:url']")["content"]
            @postData[:description] = doc.at("meta[property='og:description']")["content"]
          elsif (doc.at("meta[name='medium']")["content"] == "video")
            @postData[:author] = CGI.parse(URI.parse(set_url_params[:instaurl]).query)["taken-by"].join
            @postData[:videoUrl] = doc.at("meta[property='og:video:secure_url']")["content"]
            @postData[:link] = doc.at("meta[property='og:url']")["content"]
            @postData[:description] = doc.at("meta[property='og:description']")["content"]
          end
        end
  		}
  		format.js{
  			doc = Nokogiri::HTML(open(set_url_params[:instaurl]))
  			if !(doc.blank?)
          @postData = Hash.new
          if (doc.at("meta[name='medium']")["content"] == "image")            
            @postData[:author] = CGI.parse(URI.parse(set_url_params[:instaurl]).query)["taken-by"].join
            @postData[:imgUrl] = doc.at("meta[property='og:image']")["content"]
            @postData[:link] = doc.at("meta[property='og:url']")["content"]
            @postData[:description] = doc.at("meta[property='og:description']")["content"]
          elsif (doc.at("meta[name='medium']")["content"] == "video")
            @postData[:author] = CGI.parse(URI.parse(set_url_params[:instaurl]).query)["taken-by"].join
            @postData[:videoUrl] = doc.at("meta[property='og:video:secure_url']")["content"]
            @postData[:link] = doc.at("meta[property='og:url']")["content"]
            @postData[:description] = doc.at("meta[property='og:description']")["content"]
          end
        end
  		}
  	end  	  	
  end


  private

  def set_url_params
  	params.require(:url).permit(:instaurl)		  	
  end
end
