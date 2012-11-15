require 'pp'
require 'yajl/json_gem'
require 'stringio'
require 'cgi'

module GitHub
  module Resources
    module Helpers
      STATUSES = {
        200 => '200 OK',
        201 => '201 Created',
        202 => '202 Accepted',
        204 => '204 No Content',
        301 => '301 Moved Permanently',
        304 => '304 Not Modified',
        401 => '401 Unauthorized',
        403 => '403 Forbidden',
        404 => '404 Not Found',
        409 => '409 Conflict',
        422 => '422 Unprocessable Entity',
        500 => '500 Server Error'
      }

      def headers(status, head = {})
        css_class = (status == 204 || status == 404) ? 'headers no-response' : 'headers'
        lines = ["Status: #{STATUSES[status]}"]
        head.each do |key, value|
          lines << "#{key}: #{value}"
        end

        %(<pre class="#{css_class}"><code>#{lines * "\n"}</code></pre>\n)
      end

      def json(key)
        hash = case key
          when Hash
            h = {}
            key.each { |k, v| h[k.to_s] = v }
            h
          when Array
            key
          else
            Resources.const_get(key.to_s.upcase)
        end

        hash = yield hash if block_given?

        %(<pre class="highlight"><code class="language-javascript">) +
          JSON.pretty_generate(hash) + "</code></pre>"
      end

      def text_html(response, status, head = {})
        hs = headers(status, head.merge('Content-Type' => 'text/html'))
        res = CGI.escapeHTML(response)
        hs + %(<pre class="highlight"><code>) + res + "</code></pre>"
      end
    end

    OK_RESPONSE = {
        "opstat" => "ok",
    }

    OK_EMPTY_RESPONSE = OK_RESPONSE.merge({
        "response" => {}
    })

    LANG_PAIRS = OK_RESPONSE.merge(
        "response" =>
            [
                {"lc_src"=>"ja", "lc_tgt"=>"en", "tier"=>"machine", "unit_price"=>"0.0"},
                {"lc_src"=>"ja", "lc_tgt"=>"es", "tier"=>"machine", "unit_price"=>"0.0"},
                {"lc_src"=>"ja", "lc_tgt"=>"en", "tier"=>"standard", "unit_price"=>"0.0300"},
                {"lc_src"=>"ja", "lc_tgt"=>"es", "tier"=>"standard", "unit_price"=>"0.0300"},
                {"lc_src"=>"ja", "lc_tgt"=>"en", "tier"=>"pro", "unit_price"=>"0.0600"},
                {"lc_src"=>"ja", "lc_tgt"=>"es", "tier"=>"pro", "unit_price"=>"0.0600"},
                {"lc_src"=>"ja", "lc_tgt"=>"en", "tier"=>"ultra", "unit_price"=>"0.0900"},
                {"lc_src"=>"ja", "lc_tgt"=>"es", "tier"=>"ultra", "unit_price"=>"0.0900"}
            ]
    )

    JOBS_POST = OK_RESPONSE.merge(
        "response" => {
            "order_id"=>"109655",
            "job_count"=>3,
            "credits_used"=>"0.30",
            "currency"=>"USD"}
    )

    JOBS_ORDER_GET = OK_RESPONSE.merge(
        "response"=>{
            "order"=>{
                "order_id"=> "232",
                "total_credits"=>"0.30",
                "currency"=>"USD",
                "total_units"=>6,
                "as_group"=>0,
                "jobs_available"=>["243646", "243647", "243645"],
                "jobs_pending"=>[],
                "jobs_reviewable"=>[],
                "jobs_approved"=>[],
                "jobs_queued" => 0,
                "total_jobs"=>"3"
            }
        }
    )

    JOB_GET = OK_RESPONSE.merge(
        {
            "response"=>{
                "job"=>{
                    "job_id"=>"384985",
                    "slug"=>"APIJobtest",
                    "body_src"=>"plop!",
                    "lc_src"=>"en",
                    "lc_tgt"=>"ja",
                    "unit_count"=>"1",
                    "tier"=>"standard",
                    "credits"=>"0.05",
                    "status"=>"available",
                    "eta"=>"",
                    "ctime"=>1313475693,
                    "auto_approve"=>"0",
                    "custom_data"=>"1234567"
                }
            }
        }
    )

    ACCOUNT_STATS = OK_RESPONSE.merge(
        "response" => {
            "credits_spent" => "1023.31",
            "user_since" => 1234089500
        }
    )

    ACCOUNT_BALANCE = OK_RESPONSE.merge(
        "response" => {
            "credits" => "25.32"
        }
    )

    REVISIONS_GET = OK_RESPONSE.merge(
        "response" => {
            "job_id" => '...',
            "revisions" => [
                {"ctime" => '...', "rev_id" => '...'},
                {"ctime" => '...', "rev_id" => '...'},
                {"ctime" => '...', "rev_id" => '...'},
                '...'
            ]
        }
    )

    REVISION_GET = OK_RESPONSE.merge(
        "response" => {
            "revision" => {
                'ctime' => '...',
                'body_tgt' => '...'
            }
        }
    )

    FEEDBACK_GET = OK_RESPONSE.merge(
        "response" => {
            "feedback" => {
                'rating' => '3.0',
                'for_translator' => '...'
            }
        }
    )

    COMMENTS_GET = OK_RESPONSE.merge(
        "response" => {
            "thread" => [
                {
                    "body" => "....",
                    "author" => "translator",
                    "ctime" => 1266322028
                },
                {
                    "body" => "....",
                    "author" => "customer",
                    "ctime" => 1266324432
                }
                ]
        }
    )

    JOB_GROUP_GET = OK_RESPONSE.merge(
        "response" => {
            "jobs" => [
                {"job_id" => "5343"},
                {"job_id" => "5344"},
                {"job_id" => "5345"},
                {"job_id" => "5346"}
            ],
            "ctime" => 319238102
        }
    )

    JOBS_POST_ALL_NEW = OK_RESPONSE.merge(
        "response" => {
            "group_id" => 23015,
            "order_id" => "139370",
            "job_count" => "10",
            "credits_used" => "100.45",
            "currency" => "USD"
        }
    )

    JOBS_POST_ALL_OLD = OK_RESPONSE.merge(
        "response" => {
            "jobs" => {
                "job_1" => [
                    {
                        "job_id"=>"922599",
                        "slug"=>"slug 0",
                        "body_src"=>"This is a random string",
                        "lc_src"=>"en",
                        "lc_tgt"=>"ja",
                        "unit_count"=>"10",
                        "tier"=>"ultra_pro",
                        "credits"=>"1.70",
                        "currency"=>"USD",
                        "status"=>"approved",
                        "eta"=>-1,
                        "ctime"=>1348045507,
                        "auto_approve"=>"0",
                        "body_tgt"=>"This is a random string in japanese"
                    }
                ],
                "job_2" => [
                    {
                        "job_id"=>"922560",
                        "slug"=>"slug 0",
                        "body_src"=>"This is another random string",
                        "lc_src"=>"en",
                        "lc_tgt"=>"ja",
                        "unit_count"=>"10",
                        "tier"=>"ultra_pro",
                        "credits"=>"1.70",
                        "currency"=>"USD",
                        "status"=>"approved",
                        "eta"=>-1,
                        "ctime"=>1348045507,
                        "auto_approve"=>"0",
                        "body_tgt"=>"This is another random string in japanese"
                    }
                ],
            }
        }
    )

    JOBS_POST_MIX = OK_RESPONSE.merge(
        "response" => {
            "jobs" => {
                "job_1" => [
                    {"job_id" => "352691" },
                    {"job_id" => "352692"}
                ],
                "job_2" => [
                    {"job_id" => "352693" }
                ]
            },
            "order_id" => "139370",
            "job_count" => "5",
            "credits_used" => "14.50",
            "currency" => "USD"
        }
    )

    JOBS_POST_DUPLICATES = OK_RESPONSE.merge(

        "response"=>{
                "jobs"=>{
                    "job_2"=>{
                        "duplicate"=>"job_1",
                        "custom_data"=>""
                    },
                    "job_3"=>{
                        "duplicate"=>"job_1",
                        "custom_data"=>""
                    },
                    "job_4"=>{
                        "duplicate"=>"job_1",
                        "custom_data"=>""
                    }
                },
                "order_id"=>"122900",
                "job_count"=>2,
                "credits_used"=>"0.40",
                "currency"=>"USD"}
    )

    JOBS_GET = OK_RESPONSE.merge(

        "response" => [
            {"job_id" => 123, 'ctime' => '...'},
            {"job_id" => 425, 'ctime' => '...'},
            {"job_id" => 274, 'ctime' => '...'}
        ]
    )

    JOBS_BY_IDS_GET = OK_RESPONSE.merge(
 
        "response" => {
            "jobs" => [
                {
                    "job_id" => "1",
                    "body_src" => "This is a short story",
                    "lc_src" => "en",
                    "lc_tgt" => "jp",
                    "unit_count" => "5",
                    "tier" => "standard",
                    "credits" => "0.25",
                    "currency" => "USD",
                    "status" => "available",
                    "eta" => 25308,
                    "ctime" => 1352879655,
                    "callback_url" => "http://yourapp.com/gengo_callback/job/1",
                    "auto_approve" => "1",
                    "custom_data" => "{internal_id: 2311}"
                },
                {
                    "job_id" => "2",
                    "body_src" => "This is a short story as well",
                    "lc_src" => "en",
                    "lc_tgt" => "jp",
                    "unit_count" => "7",
                    "tier" => "standard",
                    "credits" => "0.35",
                    "currency" => "USD",
                    "status" => "available",
                    "eta" => 25308,
                    "ctime" => 1352879764,
                    "callback_url" => "http://yourapp.com/gengo_callback/job/2",
                    "auto_approve" => "1",
                    "custom_data" => "{internal_id: 2312}"
                }
            ]
        }
    )

    LANG_PAIRS_GET = OK_RESPONSE.merge(
        "response" => [
            {
                "lc_src" => "de",
                "lc_tgt" => "en",
                "tier" => "standard",
                "unit_price" => "0.0500"
            },
            {
                "lc_src" => "de",
                "lc_tgt" => "en",
                "tier" => "pro",
                "unit_price" => "0.1000"
            },
            {
                "lc_src" => "de",
                "lc_tgt" => "en",
                "tier" => "ultra",
                "unit_price" => "0.1500"
            }
        ]
    )

    LANGS_GET = OK_RESPONSE.merge(
        "response" => [
            {
                "language" => "English",
                "localized_name" => "English",
                "lc" => "en",
                "unit_type" => "word"
            },
            {
                "language" => "Japanese",
                "localized_name" => "\u65e5\u672c\u8a9e",
                "lc" => "ja",
                "unit_type" => "character"
            },
            {
                "language" => "Spanish (Spain)",
                "localized_name" => "Espa\u00f1ol",
                "lc" => "es",
                "unit_type" => "word"
            }
        ]
    )

    QUOTE_POST = OK_RESPONSE.merge(
        "response" => {
            "jobs" => [
                {"job_1" => {
                    "unit_count" => 324,
                    "credits" => 16.20
                }},
                {"job_2" => {
                    "unit_count" => 42,
                    "credits" => 4.20
                }}
            ]
        }
    )

    QUOTE_FILES_POST = OK_RESPONSE.merge(
        "response"=>{
            "jobs"=>{
                "job_1"=>{
                    "unit_count"=>0,
                    "credits"=>"0.00",
                    "eta"=>0,
                    "currency"=>"USD",
                    "identifier"=>"49427e41a1b6cefd7444b0d27ec165e7481658791885e71b7602c6babfc80b77",
                    "images"=>[],
                    "type"=>"file",
                    "lc_src"=>"en",
                    "body"=>"",
                    "title"=>"video_on_demand.txt"
                    },
                "job_2"=>{
                    "unit_count"=>0,
                    "credits"=>"0.00",
                    "eta"=>0,
                    "currency"=>"USD",
                    "identifier"=>"4fd1551c3a5628f795d645394bfcd0a5442e4e7ae60ad1f163424bdeb8420df4",
                    "images"=>[],
                    "type"=>"file",
                    "lc_src"=>"en",
                    "body"=>"",
                    "title"=>"japanese_file.docx"},
                "job_3"=>{"err"=>{"code"=>1802, "filename"=>"sushi_en.doc", "key"=>"job_3"}}}}
    )

    GLOSSARY_LIST_GET = OK_RESPONSE.merge(
        "response"=>[
            {
                "status"=>1,
                "source_language_code"=>"en-US",
                "description"=>nil,
                "source_language_id"=>8,
                "title"=>"1342666627_50110_en_ja_glossary.csv",
                "target_languages"=>[[14, "ja"]],
                "is_public"=>false,
                "unit_count"=>2,
                "id"=>115,
                "customer_user_id"=>50110,
                "ctime"=>"2012-07-19 02:57:10.526565"
            }
        ]
    )

    GLOSSARY_GET = OK_RESPONSE.merge(
        "response"=>{
            "status"=>1,
            "source_language_code"=>"en-US",
            "description"=>nil,
            "source_language_id"=>8,
            "title"=>"1342666627_50110_en_ja_glossary.csv",
            "target_languages"=>[[14, "ja"]],
            "is_public"=>false,
            "unit_count"=>2,
            "id"=>115,
            "customer_user_id"=>50110,
            "ctime"=>"2012-07-19 02:57:10.526565"
        }
    )

    ORDER_GET = OK_RESPONSE.merge(
        "response"=>{
                "order"=>{
                    "order_id"=> "232",
                    "total_credits"=>"0.30",
                    "currency"=>"USD",
                    "total_units"=>6,
                    "as_group"=>0,
                    "jobs_available"=>["243646", "243647", "243645"],
                    "jobs_pending"=>[],
                    "jobs_reviewable"=>[],
                    "jobs_approved"=>[],
                    "jobs_queued" => 0,
                    "total_jobs"=>"3"
                }
            }
    )

  end
end

include GitHub::Resources::Helpers
