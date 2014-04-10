            <aside>

{{* This part builds the article gallery. There can also be more than one gallery *}} 
{{ foreach $gimme->article->slideshows as $slideshow }}

          <div class="gallery aside-box">
              <h2>{{ #articleGallery# }}</h2>
              <h5>{{ $slideshow->headline }}</h5>
{{ assign var="counter" value=0 }}              
{{ foreach $slideshow->items as $item }}      
{{ assign var="counter" value=$counter+1 }}
                <a href="http://{{ $gimme->publication->site }}/{{ $item->image->original }}" rel="gallery" class="threecol gallery_thumbnail{{ if $counter%3 == 0 }} last{{ /if }}" title="{{ $item->caption }}" /><img src="{{ $item->image->src }}" width="90" height="90" alt="{{ $item->caption }}" style="max-width: 100%" rel="resizable" /></a>                         
{{ /foreach }}
            </div><!-- /#gallery -->

{{ /foreach }}

{{* this creates article map with markers for selected POIs *}}        
{{ if $gimme->article->has_map }}           
              <h2>{{ #storyPlaces# }}</h2>
                <div class="aside-box">
                  {{ map show_locations_list="false" show_big_map="false" show_reset_link="false" width="290" height="195" }}
                </div>
{{ /if }}                

{{* here we work with article attachments. .oga and .ogv/.ogg files are automatically shown with player in html5 enabled browsers (for video we are including videojs.com's HTML5 player which also plays mp4 and webm formats), all other cases just build the link for download *}}           
<!-- /#audio --> 
{{ if $gimme->article->has_attachments }} 
{{assign var=hasvideo value=0}}
{{ list_article_attachments }}
{{ if $gimme->attachment->extension == oga || $gimme->attachment->extension == mp3 || $gimme->attachment->extension == MP3  }}          
<div class="audio-attachment aside-box">
  <h2>{{ #listenAudio# }}</h2>
    <audio src="{{ uri options="articleattachment" }}" controls></audio><br>
    
</div>
{{ elseif $gimme->attachment->extension == ogv || $gimme->attachment->extension == ogg || $gimme->attachment->extension == flv || $gimme->attachment->extension == mp4 || $gimme->attachment->extension == webm }}             
    {{append var=videosources value="{{ uri options="articleattachment" }}" index="`$gimme->attachment->extension`"}}
    {{assign var = hasvideo value = true}}
{{ else }}
<div class="attachment">
    <h5><i class="icon-download-alt"></i> {{ #attachment# }}</h5><hr>
    <a href="{{ uri options="articleattachment" }}" class="btn btn-mini btn-red">{{ #download# }} | {{ $gimme->attachment->file_name }} ({{ $gimme->attachment->size_kb }}kb)</a>
    <p><em>{{ $gimme->attachment->description }}</em></p>
</div><!-- /.attachment -->
{{ /if }}      
{{ /list_article_attachments }}      
{{ /if }} 
<!-- /#audio --> 
<!-- /#download --> 
{{ if $gimme->article->has_attachments }} 
{{ list_article_attachments }}  
{{ if $gimme->attachment->extension == flv  }} 
      <div class="attachment aside-box">
          <h2>{{ #downloadFile# }}</h2>
          <p>{{ #fileOfType# }} {{ $gimme->attachment->mime_type }}</p>
          <a href="{{ uri options="articleattachment" }}">{{ $gimme->attachment->file_name }} ({{ $gimme->attachment->size_kb }}kb)</a>
          <p><em>{{ $gimme->attachment->description }}</em></p>
      </div><!-- /.attachment --> 
{{ /if }}     
{{ /list_article_attachments }}      
{{ /if }} 
<!-- /#download --> 
<!-- /#video-attachment -->     
{{ if $hasvideo == true }}

<div class="video-attachment aside-box"><!-- read http://diveintohtml5.org/video.html -->
   <h2>{{ #watchVideo# }}</h2>
    <div class="flowplayer" data-engine="flash" data-swf="{{ url static_file='assets/js/vendor/flowplayer/flowplayer.swf' }}" data-ratio="0.417">
      <video >
        {{foreach from=$videosources key=extension item=videoSource name=videoLoop}}
        <source src="{{ $videoSource }}" type='video/{{if $extension == flv }}flash{{ elseif $extension == ogv}}ogg{{ else }}{{ $extension }}{{ /if }}'>
        {{/foreach}}
      </video>
    </div>
</div>
{{ /if }}
<!-- /#video-attachment --> 



{{* here we include debate voting tool, if article type is 'debate' *}}
{{ if $gimme->article->type_name == "debate" }}
{{ include file="_tpl/debate-voting.tpl" }}
{{ /if }}               
                
                <h2>{{ #alsoIn# }} <span>{{ $gimme->section->name }}</span></h2>
                <div class="aside-box">
                    <ul class="article-list">
{{ assign var="curart" value=$gimme->article->number }}        
{{ list_articles length="5" ignore_issue="true" order="bypublishdate desc" constraints="number not $curart" }}
                    <li><h4><a href="{{ url options="article" }}">{{ $gimme->article->name }}</a></h4></li>
{{ /list_articles }}
                    </ul>
                </div>

{{ list_related_articles }}
{{ if $gimme->current_list->at_beginning }}
                <h2>{{ #relatedStories# }}</h2>
                <section class="grid-3">
{{ /if }}              
                    <article>
                        {{ include file="_tpl/img/img_onethird.tpl" }}
                        <small><a href="{{ url options="section" }}">{{ $gimme->section->name }}</a> {{ list_article_topics }}{{ if $gimme->current_list->at_beginning }}<em>/ {{ /if }}<a href="{{ url options="template topic.tpl" }}">{{ $gimme->topic->name }}</a>{{ if $gimme->current_list->at_end }}</em>{{ else }}, {{ /if }}{{ /list_article_topics }}</small>
                        <h4><a href="{{ url options="article" }}">{{ $gimme->article->name }}</a></h4>
                        <span class="time">{{ include file="_tpl/relative_date.tpl" date=$gimme->article->publish_date }} / <a href="{{ url options="article" }}#comments">{{ $gimme->article->comment_count }} {{ #comments# }}</a></span>
                    </article>
{{ if $gimme->current_list->at_end }}     
                </section>
{{ /if }}                    
{{ /list_related_articles }}
                    
            </aside><!-- / Aside -->