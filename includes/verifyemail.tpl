{if $emailVerificationIdValid}
        <div class="alert alert-success alert-verify">
          <div class="container">
            <i class="fa fa-check"></i>
            {$LANG.emailAddressVerified}
        </div>
        </div>
{elseif $emailVerificationIdValid === false}
            <div class="alert alert-danger alert-verify">
            <div class="container">
            <i class="fa fa-times-circle"></i>
            {$LANG.emailKeyExpired}
            <div class="pull-right">
                <button id="btnResendVerificationEmail" class="btn btn-danger btn-xs">
                    {$LANG.resendEmail}
                </button>
            </div>
    </div>
    </div>
{elseif $emailVerificationPending && !$showingLoginPage}
            <div class="alert alert-warning alert-verify">
            <div class="container">
            <i class="fa fa-warning"></i>
            {$LANG.verifyEmailAddress}
            <div class="pull-right">
                <button id="btnResendVerificationEmail" class="btn btn-warning btn-xs">
                    {$LANG.resendEmail}
                </button>
            </div>
        </div>
        </div>
{/if}
