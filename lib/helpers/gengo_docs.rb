module GengoDocs
    module Helpers
        module Localization
            # Returns the language_code attribute, or, if the former is nil, the
            # language code derived from the path.
            def language_code_of(item)
                (item.identifier.match(/^\/([a-z]{2})\//) || [])[1]
            end

            def language_root_url_of(item)
                language_code_of(item) ? (language_code_of(item) + '/') : ''
            end
        end
    end
end