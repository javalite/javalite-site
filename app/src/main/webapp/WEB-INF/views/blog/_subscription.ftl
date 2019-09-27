<@content for="body_class">subscription</@>

<div class="blog-subscription">
    <div class="container">
        <div class="row">
            <div class="col-xs-12 col-md-8 col-md-offset-2 p-t-15">
                <form action="https://expresspigeon.com/subscription/add_contact" method="post" class="row">
                    <input type="hidden" name="guid" value="bdf7f742-b96d-408d-ba2b-dbcda2698fbf"/>
                    <div class="col-xs-12 col-sm-6 subscription-inputs">
                        <input name="email" placeholder="Email" type="email"  class="required form-control" value="" />
                        <input placeholder="First name" class="form-control" name="first_name"/>
                        <button type="submit" class="btn bgm-red btn-block"  disabled href="#">Join our Newsletter</button>
                    </div>


                    <div class="col-xs-12 col-sm-6">
                        <div class="captcha">
                            <div class="g-recaptcha" data-sitekey="6Lcna7YUAAAAAIYm4i3SVm6zFRYfFIAL6fLzKu31" data-callback="enableForm" data-expired-callback="disabledForm"></div>
                                <span class="help-block">
                            </span>
                        </div>
                    </div>

                    <input name="outside" value="1" type="hidden"/>

                </form>
            </div>
        </div>
    </div>
</div>

<script src='https://www.google.com/recaptcha/api.js'></script>

<script type="text/javascript">
    function enableForm() {
        $('div.captcha').parents('form').find('button[type="submit"], input[type="submit"]').removeClass('disabled').attr('disabled', false);
    }
    function disabledForm() {
        $('div.captcha').parents('form').find('button[type="submit"], input[type="submit"]').addClass('disabled').attr('disabled', true);
    }
</script>