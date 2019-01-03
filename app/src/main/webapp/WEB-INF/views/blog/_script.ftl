<script>
    $(function (){
        $('table').replaceWith(function() {
            return '<div class="table-responsive">' + this.outerHTML + '</div>';
        });
    });
</script>