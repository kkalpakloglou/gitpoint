module GITPOINT
  class App < Thor

    desc "LangStats --organization", "Returns git repos language statistics for a given organization"
    method_option :organization, :type => :string, :default => "~/", :required => true, :aliases => "-p"
    def langstats
      say Rainbow("Connecting to github & fetching organization\'s repos...").bright
      repos = Git.new.fetch(:all, {org: options[:organization], visibility: 'public'})
      if repos[:status] == 200
        say Rainbow("Organization\'s repos fetched successfully!").green
      else
        say Rainbow("Something went wrong!").red
        say Rainbow(repos[:error_message]).red
        return
      end

      #what if reponse is nil or not what expected
      @repositories = repos[:response]

      say Rainbow("Found #{@repositories.count} repositories for this user/organization").green
      return if @repositories.count.zero?

      fetch_repository_names

      @languages = []

      say Rainbow("Fetching repos\'s languages...").bright
      @repository_names.each do |repo|
        repo_languages = Git.new.fetch(:list_languages, {user: options[:organization], repo: repo})
        if repos[:status] == 200
          @languages << repo_languages[:response].keys unless repo_languages[:response].nil?
        else
          say Rainbow("Something went wrong!").red
          say Rainbow(repos[:error_message]).red
          return
        end
      end

      say Rainbow("Computng results...").bright
      calculate_language_appearance

      results = {
        "organization" => options[:organization],
        "languages" => Hash[@language_hash.sort_by {|k, v| -v}]
      }

      say Rainbow(JSON.pretty_generate(results)).green
    end

    no_commands do
      private
      def calculate_language_appearance
        flat_array_of_languages = @languages.flatten
        @language_hash = flat_array_of_languages.group_by {|e| e}.inject({}) {|h, (k,v)| h.merge!(k => (v.count / flat_array_of_languages.count.to_f).round(2))}
      end

      def fetch_repository_names
        @repository_names = @repositories.map(&:name).to_a
      end
    end
  end

end
