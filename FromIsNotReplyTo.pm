###################
# This is property of eXtremeSHOK.com
# You are free to use, modify and distribute, however you may not remove this notice.
# Copyright (c) Adrian Jon Kriel :: admin@extremeshok.com
##################
# Spam often uses a different From: and Reply-To:
# Whilst most legitimate email does not
# Sometimes the From: and Reply-To: are different, 
# but the domains will be the same.
# If the domains are different the email is sapm.
# Originially based on: scripts by Omar David Zapi�n L�pez
##################

package FromIsNotReplyTo;
1;
use strict;
use Mail::SpamAssassin;
use Mail::SpamAssassin::Plugin;
our @ISA = qw(Mail::SpamAssassin::Plugin);

sub new {
        my ($class, $mailsa) = @_;
        $class = ref($class) || $class;
        my $self = $class->SUPER::new( $mailsa );
        bless ($self, $class);
        $self->register_eval_rule ( 'check_for_from_is_not_reply_to' );
        
        return $self;
}

sub check_for_from_is_not_reply_to {
        my ($self, $msg) = @_;
        my $from = $msg->get( 'From:addr' );
        my $replyTo = $msg->get( 'Reply-To:addr' );
        #Mail::SpamAssassin::Plugin::dbg( "FromIsNotReplyTo: Comparing '$from'/'$replyTo" );
        if ( $from ne '' && $replyTo ne '' && $from ne $replyTo ) {
                return 1
        }
        return 0;
}