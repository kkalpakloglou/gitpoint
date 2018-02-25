module GITPOINT
  class Git < Thor
    def initialize
      @@git ||= Github.new basic_auth: basic_authentication
    end

    no_commands do

      def fetch(method_name, options = {})
        status, response, error_message = nil
        begin
          response = @@git.repos.public_send(method_name, options)
          status   = response.headers.status
        rescue Github::Error::GithubError => e
          if e.is_a? Github::Error::ServiceError
            # handle GitHub service errors such as 404
            error_message = "A Service Error occured! \n #{e.message}"
          elsif e.is_a? Github::Error::ClientError
            # handle client errors e.i. missing required parameter in request
            error_message = "A Client Error occured! \n #{e.message}"
          else
            error_message = "An unknown error occured!"
          end
        rescue => e
          error_message = "An internal Error occured! \n #{e}"
        end
        return {response: response, status: status, error_message: error_message}
      end

      private
      def basic_authentication
        if ENV['gihub_login'].present? && ENV['gihub_password'].present?
          return [ENV['gihub_login'], ENV['gihub_password']].join(":")
        else
          return nil
        end
      end
    end
  end
end
