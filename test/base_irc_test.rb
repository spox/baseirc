
$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'baseirc'

class BaseIrcTest < Test::Unit::TestCase
    def setup
        @ary = []
        @irc = BaseIRC::IRC.new(@ary)
    end

    def test_pass
        @irc.pass('test')
        assert_equal(1, @ary.size)
        assert_equal('PASS test', @ary.pop)
    end

    def test_nick
        @irc.nick('fubar')
        assert_equal(1, @ary.size)
        assert_equal('NICK fubar', @ary.pop)
    end

    def test_user
        @irc.user('fubar', 'm', 'spox')
        assert_equal(1, @ary.size)
        assert_equal('USER fubar m * :spox', @ary.pop)
    end

    def test_oper
        @irc.oper('fubar', 'pass')
        assert_equal(1, @ary.size)
        assert_equal('OPER fubar pass', @ary.pop)
    end

    def test_mode_user
        @irc.mode('spox', '+r')
        assert_equal(1, @ary.size)
        assert_equal('MODE spox +r', @ary.pop)
    end

    def test_mode_channel
        @irc.mode(nil, '+m', '#fubar')
        assert_equal(1, @ary.size)
        assert_equal('MODE #fubar +m ', @ary.pop)
    end

    def test_mode_channel_target
        @irc.mode('spox', '+b', '#fubar')
        assert_equal(1, @ary.size)
        assert_equal('MODE #fubar +b spox', @ary.pop)
    end

    def test_quit
        @irc.quit('done')
        assert_equal(1, @ary.size)
        assert_equal('QUIT :done', @ary.pop)
    end

    def test_squit
        @irc.squit('localhost', 'done')
        assert_equal(1, @ary.size)
        assert_equal('SQUIT localhost :done', @ary.pop)
    end

    def test_join
        @irc.join("#chan")
        assert_equal(1, @ary.size)
        assert_equal('JOIN #chan', @ary.pop)
    end

    def test_join_key
        @irc.join('#chan', 'pass')
        assert_equal(1, @ary.size)
        assert_equal('JOIN #chan pass', @ary.pop)
    end

    def test_part
        @irc.part('#chan', 'done')
        assert_equal(1, @ary.size)
        assert_equal('PART #chan :done', @ary.pop)
    end

    def test_topic
        @irc.topic('#chan', 'new topic')
        assert_equal('TOPIC #chan :new topic', @ary.pop)
    end

    def test_names
        @irc.names('#a')
        assert_equal('NAMES #a', @ary.pop)
    end

    def test_names_target
        @irc.names('#a', 'localhost')
        assert_equal('NAMES #a localhost', @ary.pop)
    end

    def test_list
        @irc.list('#chan')
        assert_equal('LIST #chan', @ary.pop)
        @irc.list
        assert_equal('LIST', @ary.pop)
    end

    def test_invite
        @irc.invite('fubar', '#chan')
        assert_equal('INVITE fubar #chan', @ary.pop)
    end

    def test_kick
        @irc.kick('fubar', '#chan', 'done')
        assert_equal('KICK #chan fubar :done', @ary.pop)
    end

    def test_privmsg
        @irc.privmsg('fubar', 'my message')
        assert_equal('PRIVMSG fubar :my message', @ary.pop)
        @irc.privmsg('#chan', 'my message')
        assert_equal('PRIVMSG #chan :my message', @ary.pop)
    end

    def test_notice
        @irc.notice('fubar', 'my message')
        assert_equal('NOTICE fubar :my message', @ary.pop)
        @irc.notice('#chan', 'my message')
        assert_equal('NOTICE #chan :my message', @ary.pop)
    end

    def test_motd
        @irc.motd('localhost')
        assert_equal('MOTD localhost', @ary.pop)
    end

    def test_lusers
        @irc.lusers('mask', 'localhost')
        assert_equal('LUSERS mask localhost', @ary.pop)
    end

    def test_version
        @irc.version('localhost')
        assert_equal('VERSION localhost', @ary.pop)
    end

    def test_stats
        @irc.stats('a', 'localhost')
        assert_equal('STATS a localhost', @ary.pop)
    end

    def test_stats_bad
        assert_raise(ArgumentError) do
            @irc.stats('fubar', 'localhost', @ary.pop)
        end
    end

    def test_links
        @irc.links('localhost', 'mask')
        assert_equal('LIST localhost mask', @ary.pop)
    end

    def test_time
        @irc.time('localhost')
        assert_equal('TIME localhost', @ary.pop)
    end

    def test_connect
        @irc.connect('lhost', 3999, 'rhost')
        assert_equal('CONNECT lhost 3999 rhost', @ary.pop)
    end

    def test_trace
        @irc.trace('localhost')
        assert_equal('TRACE localhost', @ary.pop)
    end

    def test_admin
        @irc.admin('host')
        assert_equal('ADMIN host', @ary.pop)
    end

    def test_info
        @irc.info('localhost')
        assert_equal('INFO localhost', @ary.pop)
    end

    def test_servlist
        @irc.servlist('mask', 'localhost')
        assert_equal('SERVLIST mask localhost', @ary.pop)
    end

    def test_squery
        @irc.squery('service', 'test')
        assert_equal('SQUERY service test', @ary.pop)
    end


    def test_who
        @irc.who('mask')
        assert_equal('WHO mask', @ary.pop)
        @irc.who('mask', true)
        assert_equal('WHO mask o', @ary.pop)
    end

    def test_whois
        @irc.whois('fubar')
        assert_equal('WHOIS fubar', @ary.pop)
        @irc.whois('fubar', 'localhost')
        assert_equal('WHOIS localhost fubar', @ary.pop)
    end

    def test_whowas
        @irc.whowas('fubar')
        assert_equal('WHOWAS fubar', @ary.pop)
        @irc.whowas('fubar', 2)
        assert_equal('WHOWAS fubar 2', @ary.pop)
        @irc.whowas('fubar', 2, 'host')
        assert_equal('WHOWAS fubar 2 host', @ary.pop)
    end

    def test_kill
        @irc.kill('fubar', 'done')
        assert_equal('KILL fubar :done', @ary.pop)
    end

    def test_ping
        @irc.ping
        assert_equal('PING', @ary.pop)
        @irc.ping('FUBAR')
        assert_equal('PING FUBAR', @ary.pop)
    end

    def test_pong
        @irc.pong('localhost', 'fubar')
        assert_equal('PONG localhost fubar', @ary.pop)
    end

    def test_away
        @irc.away
        assert_equal('AWAY :', @ary.pop)
        @irc.away('gone')
        assert_equal('AWAY :gone', @ary.pop)
    end

    def test_unaway
        @irc.unaway
        assert_equal('AWAY', @ary.pop)
    end

    def test_rehash
        @irc.rehash
        assert_equal('REHASH', @ary.pop)
    end

    def test_die
        @irc.die
        assert_equal('DIE', @ary.pop)
    end

    def test_restart
        @irc.restart
        assert_equal('RESTART', @ary.pop)
    end

    def test_summon
        @irc.summon('fubar', 'blah', '#chan')
        assert_equal('SUMMON fubar blah #chan', @ary.pop)
    end

    def test_users
        @irc.users('target')
        assert_equal('USERS target', @ary.pop)
    end

    def test_wallops
        @irc.wallops('blah blah')
        assert_equal('WALLOPS :blah blah', @ary.pop)
    end

    def test_userhost
        @irc.userhost('fubar')
        assert_equal('USERHOST fubar', @ary.pop)
    end

    def test_ison
        @irc.ison('fubar')
        assert_equal('ISON fubar', @ary.pop)
    end

    def test_raw
        @irc.raw('fubar')
        assert_equal('fubar', @ary.pop)
    end

end
