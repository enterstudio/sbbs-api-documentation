require 'pp'
require 'yajl/json_gem'
require 'stringio'

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
          case key
            when :pagination
              lines << 'Link: <https://api.github.com/resource?page=2>; rel="next",'
              lines << '      <https://api.github.com/resource?page=5>; rel="last"'
            else lines << "#{key}: #{value}"
          end
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
          else Resources.const_get(key.to_s.upcase)
        end

        hash = yield hash if block_given?

        %(<pre class="highlight"><code class="language-javascript">) +
          JSON.pretty_generate(hash) + "</code></pre>"
      end
    end

    EXAMPLE_SUCCESS = {
        "root"    => "blabla..",
        "time"    => 1331979271,
        "cost"    => 4,
        "success" => true
    }

    EXAMPLE_ERROR = {
        "root"    => "blabla..",
        "time"    => 1331979271,
        "cost"    => 4,
        "error"   => "blablabla..",
        "success" => false
    }

    TOKEN = {
        "id"    => "fool",
        "name"  => "\u732b\u55b5",
        "token" => "Zm9vbA==:==sadfwdllLk0n2ltyx5QKO"
    }

    NOTIFICATIONS = {
        "mails" => [{
            "id"     => 3,
            "sender" => "one",
            "title"  => "[\u7cfb\u7edf]BBS\u8fd1\u671f\u529f\u80fd\u6539\u8fdb",
        }],
        "ats" => [{
            "board" => "Test",
            "id"    => 672354391,
            "user"  => "fool",
            "title" => "test"
        }],
        "replies" => [{
            "board" => "Test",
            "id"    => 672354391,
            "user"  => "fool",
            "title" => "test"
        }]
    }

    SECTIONS = {
        "boards" => [{
            "name"        => "\u672c\u7ad9\u7cfb\u7edf",
            "description" => "[\u76ee\u5f55]",
            "boards"      => [{
                "name"        => "Announce",
                "description" => "\u7ad9\u52a1\u516c\u544a",
                "count"       => 1758,
                "users"       => 4,
                "bm"          => ["SYSOP"],
                "leaf"        => true
            }, {
                "name"        => "Blog",
                "description" => "Blog\u5929\u5730",
                "count"       => 1,
                "users"       => 0,
                "bm"          => ["[\u013f\u00bc]"],
                "leaf"        => false,
                "boards"      => [{
                    "name"        => "BlogApply",
                    "description" => "\u535a\u5ba2\u7533\u8bf7",
                    "count"       => 2318,
                    "users"       => 1,
                    "bm"          => ["shopping"],
                    "leaf"        => true
                }]
            }]
        }]
    }

    BOARD_GET ={"topics"=>[{
        "id"=>402645,"reid"=>402645,"board"=>"SEUExpress","size"=>32,"unread"=>true,"top"=>false,"mark"=>false,"author"=>"xiaoyasi","time"=>1332983732,"title"=>"\u5927\u5bb6\u7535\u8111\u90fd\u7528\u4ec0\u4e48\u5b57\u5178\uff1f","replies"=>13,"last_author"=>"seuforest","last_time"=>1333028559,"read"=>384},{
        "id"=>402643,"reid"=>402643,"board"=>"SEUExpress","size"=>602,"unread"=>true,"top"=>false,"mark"=>false,"author"=>"angelqiao","time"=>1332983108,"title"=>"3\u670826\u65e5\uff01\u4fdd\u536b\u5904\u53c8\u6293\u83b7\u4e00\u76d7\u7a83\u6469\u6258\u8f66\u7684\u5acc\u7591\u4eba\uff01","replies"=>5,"last_author"=>"kkxmn","last_time"=>1333018514,"read"=>54},{
        "id"=>402663,"reid"=>402663,"board"=>"SEUExpress","size"=>1611,"unread"=>true,"top"=>false,"mark"=>false,"author"=>"hander","time"=>1333017997,"title"=>"\u6fb3\u5927\u5229\u4e9a\u8fea\u80af\u5927\u5b66\u2014\u62db2012\u5e74\u672c\u79d1\u5e94\u5c4a\u6bd5\u4e1a\u751f\/\u7855\u58eb\u5e94\u5c4a\u6bd5\u4e1a\u751f\u2014\u5c31","replies"=>0,"last_author"=>"hander","last_time"=>1333017997,"read"=>13},{
        "id"=>402662,"reid"=>402662,"board"=>"SEUExpress","size"=>36,"unread"=>true,"top"=>false,"mark"=>false,"author"=>"tigerheart","time"=>1333015903,"title"=>"\u7559\u56ed\u5bbe\u9986\u5355\u95f4\u4e00\u665a\u4e0a\u591a\u5c11\u94b1\uff1f","replies"=>0,"last_author"=>"tigerheart","last_time"=>1333015903,"read"=>20},{
        "id"=>402268,"reid"=>402268,"board"=>"SEUExpress","size"=>0,"unread"=>true,"top"=>false,"mark"=>false,"author"=>"liangxianch","time"=>1332395710,"title"=>" \u590d\u65e6BBS\u4e0a\u5728\u8ba8\u8bba\u201c\u4e00\u516c\u65a4\u6c34\u662f\u5426\u80fd\u6d6e\u8d772\u516c\u65a4\u7684\u6728\u5934\u201d\uff0c\u5df2\u7ecf\u8ba8\u8bba","replies"=>14,"last_author"=>"shuifeng","last_time"=>1332999618,"read"=>418},{
        "id"=>402618,"reid"=>402618,"board"=>"SEUExpress","size"=>18,"unread"=>true,"top"=>false,"mark"=>false,"author"=>"guxiaojiang","time"=>1332916330,"title"=>"\u5b66\u8f66","replies"=>2,"last_author"=>"ruobai","last_time"=>1332994486,"read"=>79},{
        "id"=>402642,"reid"=>402642,"board"=>"SEUExpress","size"=>1033,"unread"=>true,"top"=>false,"mark"=>false,"author"=>"angelqiao","time"=>1332982884,"title"=>"3\u670818\u65e5\uff01\u4e5d\u9f99\u6e56\u6293\u83b7\u4e00\u5077\u76d7\u81ea\u884c\u8f66\u7684\u5acc\u7591\u4eba\uff01","replies"=>0,"last_author"=>"angelqiao","last_time"=>1332982884,"read"=>43},{
        "id"=>402640,"reid"=>402640,"board"=>"SEUExpress","size"=>977,"unread"=>true,"top"=>false,"mark"=>false,"author"=>"tingqiang","time"=>1332981413,"title"=>"\u6c5f\u82cf\u7701\u79d1\u6280\u521b\u65b0\u534f\u4f1a\u8bda\u62db\u517c\u804c","replies"=>0,"last_author"=>"tingqiang","last_time"=>1332981413,"read"=>15},{
        "id"=>402597,"reid"=>402597,"board"=>"SEUExpress","size"=>1400,"unread"=>true,"top"=>false,"mark"=>false,"author"=>"one","time"=>1332864174,"title"=>"\u65af\u56fe\u52a0\u7279\u5927\u5b66\u5408\u5531\u56e2\u7684\u4e00\u573a\u70c2\u97f3\u4e50 (\u8f6c\u8f7d)","replies"=>7,"last_author"=>"DDdog","last_time"=>1332945941,"read"=>385},{
        "id"=>402608,"reid"=>402608,"board"=>"SEUExpress","size"=>168,"unread"=>true,"top"=>false,"mark"=>false,"author"=>"zhangjieguai","time"=>1332902508,"title"=>"\u5927\u56db\u60f3\u51fa\u56fd\u65c5\u6e38\uff0c\u9700\u8981\u5b66\u9662\u540c\u610f\uff01\uff01\uff01\u600e\u4e48\u529e","replies"=>15,"last_author"=>"raytheon","last_time"=>1332936751,"read"=>270}],"total"=>8123,"time"=>1333029033,"cost"=>4,"success"=>true}

    BOARD_GET_EXPAND = {"boards"=>[{
        "name"=>"PT_Advice","description"=>"PT\u5efa\u8bae\u4e0e\u7533\u8bc9","count"=>160,"users"=>0,"bm"=>["nnzy"],"leaf"=>true},{
        "name"=>"PT_Announce","description"=>"PT\u516c\u544a","count"=>54,"users"=>0,"bm"=>["PTAdmin"],"leaf"=>true},{
        "name"=>"PT_Cafe","description"=>"PT\u5496\u5561\u5385","count"=>5011,"users"=>1,"bm"=>["adu","zhanghaibo","katze"],"leaf"=>true},{
        "name"=>"PT_Club","description"=>"\u864e\u8e1e\u9f99\u87e0PT\u7ad9\u7ba1\u7406\u7ec4\u8ba8\u8bba\u533a","count"=>2819,"users"=>1,"bm"=>["irun","one","adu"],"leaf"=>true},{
        "name"=>"PT_Help","description"=>"PT\u65b0\u624b\u533a","count"=>458,"users"=>1,"bm"=>["Saboteur"],"leaf"=>true}],"time"=>1332345231,"cost"=>3,"success"=>true}

    RESULT = {
        "result" => 0
    }

    BOARD_LIST = {
        "boards" => [
            "3eDV - 3eDV\u5f71\u89c6\u534f\u4f1a",
            "Abroad - \u98de\u8dc3\u91cd\u6d0b",
            "AcademicEvents - \u6821\u56ed\u8bb2\u5ea7\u4e0e\u6d3b\u52a8",
            "AcademicInfo - \u5b66\u672f\u52a8\u6001",
            "Administration - \u5b66\u6821\u7ba1\u7406\u4fe1\u606f",
            "Advice - \u96c6\u601d\u5e7f\u76ca",
            "Agent - \u5546\u4e1a\u4ee3\u7406",
            "AIOCardCenter - \u4e00\u5361\u901a\u7ba1\u7406\u4e2d\u5fc3",
            "Anhui - \u5fbd\u98ce\u7696\u97f5",
            "Announce - \u7ad9\u52a1\u516c\u544a",
            "Appeal - \u7533\u8bc9\u548c\u5f39\u52be",
            "Apple - \u82f9\u679c\u4e50\u56ed",
            "architecture - \u5efa\u7b51\u5b66\u9662",
            "ArtsSchools - \u827a\u672f\u5b66\u9662",
            "Asciiarts - ASCII\u5b57\u7b26\u827a\u672f",
            "AstroGeo - \u5929\u6587\u5730\u7406",
            "Astrology - \u661f\u5ea7",
            "Automation - \u81ea\u52a8\u5316\u5b66\u9662",
            "Automobile - \u5b9d\u9a6c\u5954\u9a70",
            "Badminton - \u8f7b\u7fbd\u98de\u626c"
        ]
    }

    TOPIC_GET = {"topics"=>[{
        "id"=>402645,"gid"=>402645,"reid"=>402645,"board"=>"SEUExpress","size"=>32,"unread"=>true,"top"=>false,"mark"=>false,"author"=>"xiaoyasi","time"=>1332983732,"title"=>"\u5927\u5bb6\u7535\u8111\u90fd\u7528\u4ec0\u4e48\u5b57\u5178\uff1f","content"=>"\u80fd\u591f\u5c4f\u5e55\u67e5\u8bcd\uff0c\u8bcd\u6c47\u91cf\u6bd4\u8f83\u591a\u7684\u90a3\u79cd","read"=>378},{
        "id"=>402647,"gid"=>402645,"reid"=>402645,"board"=>"SEUExpress","size"=>28,"unread"=>true,"top"=>false,"mark"=>false,"author"=>"haohaizi","time"=>1332986400,"title"=>"Re=> \u5927\u5bb6\u7535\u8111\u90fd\u7528\u4ec0\u4e48\u5b57\u5178\uff1f","content"=>"\u7075\u683c\u65af\u5427\uff0c\u6709\u9053\u4e5f\u53ef\u4ee5\u67e5\u8bcd\u7684\u3002","quote"=>"\u80fd\u591f\u5c4f\u5e55\u67e5\u8bcd\uff0c\u8bcd\u6c47\u91cf\u6bd4\u8f83\u591a\u7684\u90a3\u79cd","quoter"=>"xiaoyasi","read"=>372},{
        "id"=>402649,"gid"=>402645,"reid"=>402645,"board"=>"SEUExpress","size"=>30,"unread"=>true,"top"=>false,"mark"=>false,"author"=>"vigalove","time"=>1332988914,"title"=>"Re=> \u5927\u5bb6\u7535\u8111\u90fd\u7528\u4ec0\u4e48\u5b57\u5178\uff1f","content"=>"\u7075\u683c\u65af\u3002\u3002\u3002\n\u4e13\u4e1a\u8bcd\u6c47\u6bd4\u8f83\u5145\u8db3\u3002","quote"=>"\u80fd\u591f\u5c4f\u5e55\u67e5\u8bcd\uff0c\u8bcd\u6c47\u91cf\u6bd4\u8f83\u591a\u7684\u90a3\u79cd","quoter"=>"xiaoyasi","read"=>358}],"time"=>1333028029,"cost"=>5,"success"=>true}

    TOPIC_POST = {
        "topic" => {"id"=>672354422,"reid"=>672354422,"board"=>"Test","size"=>4,"unread"=>false,"top"=>false,"mark"=>false,"author"=>"fool","time"=>1331995046,"quoter"=>"fool","title"=>"test","content"=>"test","quote"=>"","read"=>1}
    }

    FAV_GET = {"boards"=>[{
        "name"=>"\u6d4b\u8bd5","description"=>"[\u76ee\u5f55]","leaf"=>false,"unread"=>0,"boards"=>[{
        "name"=>"BBSDev","description"=>"BBS\u5f00\u53d1\u548c\u7f16\u7a0b","leaf"=>true,"unread"=>0},{
        "name"=>"bbsnet","description"=>"\u7a7f\u68ad\u8bb0\u5f55\u533a","leaf"=>true,"unread"=>1},{
        "name"=>"Test","description"=>"\u65b0\u624b\u6d4b\u8bd5","leaf"=>true,"unread"=>0}]},{
        "name"=>"\u6d4b\u8bd52","description"=>"[\u76ee\u5f55]","leaf"=>false,"unread"=>0,"boards"=>[{
        "name"=>"\u6d4b\u8bd53","description"=>"[\u76ee\u5f55]","leaf"=>false,"unread"=>0,"boards"=>[{
        "name"=>"Test","description"=>"\u65b0\u624b\u6d4b\u8bd5","leaf"=>true,"unread"=>0}]},{
        "name"=>"Test","description"=>"\u65b0\u624b\u6d4b\u8bd5","leaf"=>true,"unread"=>0}]},{
        "name"=>"BBSDev_Club","description"=>"BBS\u7cfb\u7edf\u6280\u672f\u8ba8\u8bba\u533a","leaf"=>true,"unread"=>0},{
        "name"=>"C_CPlusPlus","description"=>"C\/C++\u8bed\u8a00","leaf"=>true,"unread"=>0},{
        "name"=>"code_report","description"=>"\u7cfb\u7edf\u4ee3\u7801\u63d0\u4ea4\u8bb0\u5f55","leaf"=>true,"unread"=>1},{
        "name"=>"Computer","description"=>"\u8ba1\u7b97\u673a\u79d1\u5b66\u4e0e\u5de5\u7a0b\u5b66\u9662","leaf"=>true,"unread"=>0},{
        "name"=>"CoSE","description"=>"\u8f6f\u4ef6\u5b66\u9662","leaf"=>true,"unread"=>0},{
        "name"=>"discuss","description"=>"\u7ad9\u52a1\u8ba8\u8bba\u5ba4","leaf"=>true,"unread"=>1},{
        "name"=>"Embedded","description"=>"\u5d4c\u5165\u5f0f\u7cfb\u7edf","leaf"=>true,"unread"=>1},{
        "name"=>"Intern","description"=>"\u5b9e\u4e60","leaf"=>true,"unread"=>1},{
        "name"=>"jobs","description"=>"\u6253\u5de5\u4e00\u65cf","leaf"=>true,"unread"=>1},{
        "name"=>"Linux","description"=>"Linux\u64cd\u4f5c\u7cfb\u7edf","leaf"=>true,"unread"=>1},{
        "name"=>"mobile","description"=>"\u624b\u673a\u901a\u4fe1","leaf"=>true,"unread"=>1},{
        "name"=>"SecondHand","description"=>"\u8df3\u86a4\u5e02\u573a","leaf"=>true,"unread"=>1},{
        "name"=>"TableGames","description"=>"\u684c\u9762\u6e38\u620f","leaf"=>true,"unread"=>1},{
        "name"=>"Test","description"=>"\u65b0\u624b\u6d4b\u8bd5","leaf"=>true,"unread"=>0}]}

    USER = {"user"=>{
        "id"=>"fool","name"=>"\u732b\u55b5","avatar"=>"http=>\/\/bbs.seu.edu.cn\/wForum\/uploadFace\/F\/fool.55.gif","lastlogin"=>1333027143,"level"=>"\u6280\u672f\u7ad9\u52a1","posts"=>513,"perform"=>107,"experience"=>4305,"medals"=>0,"logins"=>8669,"life"=>99,"gender"=>"M","astro"=>"\u5929\u67b0\u5ea7"},"time"=>1333027915,"cost"=>3,"success"=>true}

    MAILBOX_GET = {"mails"=>[{
        "id"=>3,"size"=>485,"unread"=>true,"author"=>"one","time"=>1330957343,"title"=>"[\u7cfb\u7edf]BBS\u8fd1\u671f\u529f\u80fd\u6539\u8fdb"},{
        "id"=>2,"size"=>2738,"unread"=>false,"author"=>"one","time"=>1327218970,"title"=>"\u4e1c\u5357\u5927\u5b66\u864e\u8e1e\u9f99\u87e0BBS\u7ad9\u606d\u795d\u5404\u4f4d\u7f51\u53cb\u9f99\u5e74\u65b0\u6625\u5feb\u4e50"},{
        "id"=>1,"size"=>493,"unread"=>false,"author"=>"one","time"=>1326684566,"title"=>"[\u7cfb\u7edf]\u5173\u4e8e\u5bd2\u5047\u671f\u95f4\u53d6\u6d88\u672c\u7ad9\u5bb5\u7981\u7684\u901a\u77e5"},{
        "id"=>0,"size"=>3296,"unread"=>false,"author"=>"SYSOP","time"=>1325348177,"title"=>"[\u516c\u544a]\u864e\u8e1e\u9f99\u87e0BBS\u7ad9\u7ad9\u52a1\u7ec4\u5e74\u5ea6\u8ff0\u804c\u62a5\u544a"}]
    }

    MAIL_GET = {"mail"=>{
        "id"=>3,"size"=>485,"unread"=>false,"author"=>"one","time"=>1330957343,"content"=>"[WEB]\n   1\u3001\u56de\u590d\u63d0\u9192\u53ca@\u529f\u80fd\n      \u5f53\u81ea\u5df1\u7684\u5e16\u5b50\u88ab\u56de\u590d\u65f6\uff0c\u6216\u8005\u6709\u4eba\u5728\u5e16\u5b50\u91cc\u4ee5@id\u7684\u5f62\u5f0f\u7231\u7279\u4f60\u65f6\uff0c\u4f60\u5c06\u4f1a\u6536\u5230\u901a\u77e5\n   2\u3001\u663e\u793a\u5355\u7bc7\u6587\u7ae0\u7684\u5df2\u9605\u8bfb\u6570(\u5373\u4eba\u6c14)\n      \u6587\u7ae0\u9605\u8bfb\u6570\u7531\u4e0d\u540cIP\u7684\u9605\u8bfb\u6b21\u6570\u51b3\u5b9a\uff0c\u540c\u4e00IP\u5728\u4e00\u6bb5\u65f6\u95f4\u5185\u53cd\u590d\u9605\u8bfb\u53ea\u8bb01\u6b21\u9605\u8bfb\u3002\n[Telnet]\n   1\u3001\u589e\u52a0\u56de\u590d\u63d0\u9192\u53ca@\u529f\u80fd\n      \u5728\u4e0b\u65b9\u72b6\u6001\u680f\u7684\u7528\u6237id\u65c1\u8fb9\u663e\u793a\u901a\u77e5\u6570\u76ee\uff0c\u4f7f\u7528CTRL+K\u5feb\u6377\u952e\uff0c\u7136\u540e\u9009\u62e93\u8fdb\u5165\u901a\u77e5\n   \u67e5\u770b\u754c\u9762\u3002","quote"=>"","title"=>"[\u7cfb\u7edf]BBS\u8fd1\u671f\u529f\u80fd\u6539\u8fdb"}
    }

    SEARCH_TOPICS = {"topics"=>[{
        "id"=>"672354422","title"=>"test","board"=>"Test","author"=>"fool","time"=>"20120317","mark"=>false,"read"=>"8"},{
        "id"=>"672354423","title"=>"test","board"=>"Test","author"=>"fool","time"=>"20120317","mark"=>false,"read"=>"8"},{
        "id"=>"672354424","title"=>"test","board"=>"Test","author"=>"fool","time"=>"20120317","mark"=>false,"read"=>"10"},{
        "id"=>"672354416","title"=>"test","board"=>"Test","author"=>"gfan","time"=>"20120316","mark"=>false,"read"=>"9"},{
        "id"=>"672354412","title"=>"Re=> Test","board"=>"Test","author"=>"Nine","time"=>"20120316","mark"=>false,"read"=>"11"},{
        "id"=>"672354415","title"=>"Re=> Test","board"=>"Test","author"=>"Nine","time"=>"20120316","mark"=>false,"read"=>"12"},{
        "id"=>"672354414","title"=>"Re=> Test","board"=>"Test","author"=>"Nine","time"=>"20120316","mark"=>false,"read"=>"12"},{
        "id"=>"672354417","title"=>"Re=> test","board"=>"Test","author"=>"Nine","time"=>"20120316","mark"=>false,"read"=>"12"},{
        "id"=>"672354419","title"=>"test","board"=>"Test","author"=>"Italia","time"=>"20120316","mark"=>false,"read"=>"11"},{
        "id"=>"672354420","title"=>"Re=> test","board"=>"Test","author"=>"Nine","time"=>"20120316","mark"=>false,"read"=>"13"}]}

    SEARCH_BOARDS = {"boards"=>[{
        "name"=>"Sports","description"=>"\u4f53\u575b\u5feb\u8baf"},{
        "name"=>"football","description"=>"\u8db3\u7403\u4e16\u754c"}]}

    HOT_TOPTEN = {
        "topics"=>[{
        "title"=>"\u201c\u4f60\u4eec\u8fd9\u6837\u7684\u5bbf\u820d\u5728\u6574\u4e2a\u5b66\u6821\u90fd\u5c11\u89c1\u4e86\u201d","author"=>"bluesummerg","board"=>"feeling","time"=>1332059369,"id"=>431308,"replies"=>19,"read"=>"250"},{
        "title"=>"\u9ed1\u4eba\u79fb\u6c11\u6f6e\u6d8c\u4e2d\u56fd\u4e0e\u8ba1\u5212\u751f\u80b2\u7684\u53cd\u601d(\u8f6c\u8f7d)","author"=>"DDdog","board"=>"News","time"=>1332058689,"id"=>106373,"replies"=>16,"read"=>"263"},{
        "title"=>"\u5357\u95e8\u7684\u5feb\u9012\u597d\u8d35\u5440","author"=>"xxy","board"=>"JLHCampus","time"=>1332059009,"id"=>173775,"replies"=>14,"read"=>"408"},{
        "title"=>"\u6000\u5ff5\u6c99\u5858\u56ed\u7684\u5c0f\u9ed1\u732b T_T","author"=>"charlene","board"=>"Pet","time"=>1332058443,"id"=>9528,"replies"=>11,"read"=>"341"},{
        "title"=>"\u4f60\u73b0\u5728\u6700\u76f8\u4fe1\u54ea\u4e09\u4e2a\u5b57\uff1f","author"=>"DDdog","board"=>"Girls","time"=>1332056741,"id"=>228799,"replies"=>11,"read"=>"338"},{
        "title"=>"\u6cb3\u6d77\u5927\u5b66\u8ba1\u7b97\u673a\u7814\u7a76\u751fGG\u5f81\u5973\u53cb","author"=>"lichaodiego","board"=>"PieBridge","time"=>1332054859,"id"=>187991,"replies"=>7,"read"=>"1188"},{
        "title"=>"\u592a\u731b\u4e86","author"=>"mapler","board"=>"Pictures","time"=>1332059232,"id"=>223181,"replies"=>6,"read"=>"204"},{
        "title"=>"\u4ece\u56db\u724c\u697c\u5982\u4f55\u53bb55\u6240\uff1f","author"=>"joestc","board"=>"Trafficinfo","time"=>1332058796,"id"=>35703,"replies"=>5,"read"=>"172"},{
        "title"=>"\u67ef\u5357\u662f\u4e0d\u662f\u8981\u8fdb\u5165\u4e3b\u5267\u60c5\u4e86?","author"=>"sdqy","board"=>"Cartoon","time"=>1332054277,"id"=>132894,"replies"=>4,"read"=>"391"},{
        "title"=>"\u5509\uff0c\u559c\u6b22\u7684\u7537\u751f\u6709\u59b9\u5b50\u4e86","author"=>"Psychology","board"=>"Psychology","time"=>1332057468,"id"=>19718,"replies"=>4,"read"=>"746"}],"time"=>1332059807,"cost"=>5,"success"=>true}

    HOT_BOARDS = {
        "boards"=>[{
        "name"=>"SEUExpress","section"=>1,"leaf"=>true,"description"=>"\u6821\u56ed\u7279\u5feb"},{
        "name"=>"SecondHand","section"=>8,"leaf"=>true,"description"=>"\u8df3\u86a4\u5e02\u573a"},{
        "name"=>"humour","section"=>6,"leaf"=>true,"description"=>"\u5e7d\u9ed8\u4eba\u751f"},{
        "name"=>"PieBridge","section"=>7,"leaf"=>true,"description"=>"\u7f18\u5206\u7684\u5929\u7a7a"},{
        "name"=>"Girls","section"=>7,"leaf"=>true,"description"=>"\u5973\u5b69\u5fc3\u58f0"},{
        "name"=>"mobile","section"=>6,"leaf"=>true,"description"=>"\u624b\u673a\u901a\u4fe1"},{
        "name"=>"feeling","section"=>7,"leaf"=>true,"description"=>"\u6b32\u5c06\u5fc3\u4e8b\u4ed8\u7f51\u4e2d"},{
        "name"=>"jobs","section"=>8,"leaf"=>true,"description"=>"\u6253\u5de5\u4e00\u65cf"},{
        "name"=>"YanCheng","section"=>5,"leaf"=>true,"description"=>"\u76d0\u961c\u5927\u5730"},{
        "name"=>"Pictures","section"=>6,"leaf"=>true,"description"=>"\u8d34\u56fe\u677f"},{
        "name"=>"JLHCampus","section"=>1,"leaf"=>true,"description"=>"\u4e5d\u9f99\u6e56\u6821\u533a"}],"time"=>1332059879,"cost"=>4,"success"=>true}

    HOT_SECTION = {
        "topics"=>[{
        "title"=>"\u5357\u95e8\u7684\u5feb\u9012\u597d\u8d35\u5440","author"=>"xxy","board"=>"JLHCampus","time"=>1332059009,"id"=>173775,"replies"=>14,"read"=>"410"},{
        "title"=>"\u5bfb\u627e\u68a6\u60f3\u7684\u504f\u6267\u72c2\uff01\u8fdc\u666f\u80fd\u6e902012\u4e1c\u5357\u5927\u5b66\u6625\u5b63\u6821\u56ed\u62db\u8058\u5f00\u59cb\u4e86\uff01","author"=>"wudicxm","board"=>"Automation","time"=>1332056066,"id"=>75407,"replies"=>2,"read"=>"701"},{
        "title"=>"\u590d\u8bd5\u8003\u7684\u8f6f\u4ef6\u5de5\u7a0b\u57fa\u7840","author"=>"bldhdh","board"=>"CoSE","time"=>1332059262,"id"=>45104,"replies"=>2,"read"=>"21"},{
        "title"=>"\u6c42\u5408\u79df","author"=>"dongriyuwen","board"=>"SEUExpress","time"=>1332037602,"id"=>402109,"replies"=>0,"read"=>"64"},{
        "title"=>"\u8bda\u62db\u7814\u7a76\u751f\uff08\u4ee3\u53d1\uff09","author"=>"feihuafeiyu","board"=>"Automation","time"=>1332036741,"id"=>75504,"replies"=>0,"read"=>"107"},{
        "title"=>"\u6709\u8c01\u5728\u6a58\u56ed\u9644\u8fd1\u6361\u5230\u4e00\u53ea\u9ed1\u8272\u5851\u6599\u76ae\u7684\u94a5\u5319\u5417\uff1f","author"=>"tiankong","board"=>"SEUExpress","time"=>1332051024,"id"=>402110,"replies"=>0,"read"=>"12"},{
        "title"=>"\u6c42\u8003\u7814\u8d44\u6599\uff0c\u7d27\u6025\uff01\uff01\uff01","author"=>"fjxyhy","board"=>"Transportation","time"=>1332032533,"id"=>21110,"replies"=>0,"read"=>"110"},{
        "title"=>"CATIA","author"=>"seuconan","board"=>"Mechanics","time"=>1332041032,"id"=>36708,"replies"=>0,"read"=>"25"},{
        "title"=>"\u6025\uff01\uff01\uff01\u8003\u7814\u6c42\u52a9","author"=>"shijiemori","board"=>"ChemicalEngineer","time"=>1332047255,"id"=>19743,"replies"=>0,"read"=>"19"}],"time"=>1332060173,"cost"=>8,"success"=>true}

  end
end

include GitHub::Resources::Helpers
