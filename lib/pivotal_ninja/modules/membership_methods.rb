module PivotalNinja
  module Modules
    module MembershipMethods
      def memberships(project_id)
        JSON(connection["/projects/#{project_id}/memberships"].get)
          .map{|me| PivotalNinja::Membership.new.extend(PivotalNinja::Renderer::MembershipRenderer).from_json(me.to_json)}
      rescue RestClient::Forbidden, RestClient::ResourceNotFound => e
        puts "Error: #{e.message}"
        nil
      end

      def find_membership(project_id, membership_id)
        PivotalNinja::Membership.new.extend(PivotalNinja::Renderer::MembershipRenderer)
          .from_json(connection["/projects/#{project_id}/memberships/#{membership_id}"].get)
      rescue RestClient::Forbidden, RestClient::ResourceNotFound => e
        puts "Error: #{e.message}"
        nil
      end
    end
  end
end
