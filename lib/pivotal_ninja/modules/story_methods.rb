module PivotalNinja
  module Modules
    module StoryMethods
      def stories(project_id)
        JSON(connection["/projects/#{project_id}/stories"].get.force_encoding('utf-8'))
          .map{|me| PivotalNinja::Story.new.extend(PivotalNinja::Renderer::StoryRenderer).from_json(me.to_json)}
      rescue RestClient::Forbidden, RestClient::ResourceNotFound => e
        puts "Error: #{e.message}"
        nil
      end

      def find_story(project_id, story_id)
        PivotalNinja::Story.new.extend(PivotalNinja::Renderer::StoryRenderer).from_json(connection["/projects/#{project_id}/stories/#{story_id}"].get)
      rescue RestClient::Forbidden, RestClient::ResourceNotFound => e
        puts "Error: #{e.message}"
        nil
      end
    end
  end
end
