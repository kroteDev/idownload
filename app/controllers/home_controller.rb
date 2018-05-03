class HomeController < ApplicationController
	require 'open-uri'
	require 'nokogiri'
	require 'cgi'

  before_action :set_url_params, only: [:makerequest]
  def index  	
  end
  def makerequest
  	respond_to do |format|
  		format.html{
  			doc = Nokogiri::HTML(open(set_url_params[:instaurl]))
  			if !(doc.blank?)
          @postData = Hash.new
          @postData[:author] = CGI.parse(URI.parse(set_url_params[:instaurl]).query)["taken-by"].join if set_url_params[:instaurl].include? 'taken-by'
          @postData[:link] = doc.at("meta[property='og:url']")["content"]
          @postData[:description] = doc.at("meta[property='og:description']")["content"]
          if (doc.at("meta[name='medium']")["content"] == "image")                        
            @postData[:imgUrl] = doc.at("meta[property='og:image']")["content"]
          elsif (doc.at("meta[name='medium']")["content"] == "video")            
            @postData[:videoUrl] = doc.at("meta[property='og:video:secure_url']")["content"]            
          end
        end
  		}
  		format.js{
  			doc = Nokogiri::HTML(open(set_url_params[:instaurl]))
  			if !(doc.blank?)
          @postData = Hash.new
          @postData[:author] = CGI.parse(URI.parse(set_url_params[:instaurl]).query)["taken-by"].join if set_url_params[:instaurl].include? 'taken-by'
          @postData[:link] = doc.at("meta[property='og:url']")["content"]
          @postData[:description] = doc.at("meta[property='og:description']")["content"]
          if (doc.at("meta[name='medium']")["content"] == "image")                        
            @postData[:imgUrl] = doc.at("meta[property='og:image']")["content"]
          elsif (doc.at("meta[name='medium']")["content"] == "video")            
            @postData[:videoUrl] = doc.at("meta[property='og:video:secure_url']")["content"]            
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
