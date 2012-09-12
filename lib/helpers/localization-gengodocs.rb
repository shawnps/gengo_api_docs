module GengoDocs::Helpers::Localization
    # RequiredMethods contains methods required by Nanoc3::Helpers::Localization.
    module RequiredMethods

        # Returns the language_code attribute, or, if the former is nil, the
        # language code derived from the path.
        def language_code_of(item)
            (item.identifier.match(/^\/([a-z]{2})\//) || [])[1]
        end

        # Returns the item_id attribute of the given item.
        def canonical_identifier_of(item)
            language_code   = language_code_of(item)
            pure_identifier = item.identifier[/^\/[a-z]{2}(\/.*)/, 1]

           (CANONICAL_IDENTIFIER_MAPPING[language_code] || {}).invert[pure_identifier]
        end
    end
end