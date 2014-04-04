    <script src="{{ uri static_file="assets/js/libs/jquery.jcarousel.min.js" }}"></script>
    
    <!--[if (gte IE 6)&(lte IE 8)]>
      <script type="text/javascript" src="{{ uri static_file="assets/js/libs/selectivizr-min.js" }}"></script>
    <![endif]-->
    
    {{ if $gimme->article->defined }}
      <script src="{{ url static_file='assets/js/article-rating.js' }}"></script>
  {{ /if }}

    <script type="text/javascript">
                    });
 
                uploader.init();
 
                uploader.bind('FilesAdded', function(up, files) {
                    $('#fancybox-content form#feedback-form-form div.show-value').html('Uploading...');
                    up.start();
 
                    up.refresh(); // Reposition Flash/Silverlight
                });
 
                uploader.bind('FileUploaded', function(up, file, info) {
                    $('#fancybox-content form#feedback-form-form div.show-value').html('Uploaded!');
                    var response = $.parseJSON(info['response'])['response'].split("_");
                    $('#fancybox-content form#feedback-form-form .file-holder').html('<input type="hidden" id="feedback-attachment-id" name="attachment_id" /><input type="hidden" id="feedback-attachment-type" name="attachment_type" />')
                    $('#fancybox-content form#feedback-form-form input#feedback-attachment-type').val(response[0]);
                    $('#fancybox-content form#feedback-form-form input#feedback-attachment-id').val(response[1]);
 
                    up.refresh();
                });
            }
        });
    });
    $('form#feedback-form-form').live('submit', function(e) {
        e.preventDefault();
        var form = this;
 
        {{ dynamic }}
        var data = {
            f_feedback_url: String(document.location),
            f_feedback_subject: $('input#feedback-subject', form).val(),
            f_feedback_content: $('textarea#feedback-content', form).val(),
            f_language: '{{ $gimme->language->number }}',
            f_section: '{{ $gimme->section->id }}',
            f_article: '{{ $gimme->article->number }}',
            f_publication: '{{ $gimme->publication->identifier }}',
        };
        {{ /dynamic }}
 
        if ($('#fancybox-content form#feedback-form-form input#feedback-attachment-type').val() == 'image') {
            data['image_id'] = $('#fancybox-content form#feedback-form-form input#feedback-attachment-id').val();
        } else {
            data['document_id'] = $('#fancybox-content form#feedback-form-form input#feedback-attachment-id').val();
        }
 
        $.ajax({
            type: 'POST',
            url: '{{ $view->baseUrl("/feedback/save/?format=json") }}',
            data: data,
            dataType: 'json',
            success: function(data) {
                var message;
                $.fancybox({
                    'content' : '<h2 style="text-align:center;"><span>Response</span></h2><h2 style="text-align:center;">'+ data['response'] +'<h2>'
                });
            }
        });
    });
});
    </script>
    
  <script src="{{ uri static_file="assets/js/init.js" }}"></script>
  <script src="{{ url static_file='assets/js/plugins.js' }}"></script>
  <script src="{{ url static_file='assets/js/script.js' }}"></script>