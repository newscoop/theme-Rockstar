              <article>
                    <small><a href="{{ url options="section" }}">{{ $gimme->section->name }}</a> {{ list_article_topics }}{{ if $gimme->current_list->at_beginning }}<em>/ {{ /if }}<a href="{{ url options="template topic.tpl" }}">{{ $gimme->topic->name }}</a>{{ if $gimme->current_list->at_end }}</em>{{ else }}, {{ /if }}{{ /list_article_topics }}</small>
                    <h2>{{ $gimme->article->name }}</h2>
                    <span class="date">{{ $gimme->article->publish_date|camp_date_format:"%d %M %Y" }} / {{ #by# }} {{ list_article_authors }}{{ if $gimme->author->user->defined }}<a href="{{ $view->url(['username' => $gimme->author->user->uname], 'user') }}">{{ /if }}{{ $gimme->author->name }}{{ if $gimme->author->user->defined }}</a>{{ /if }} ({{ $gimme->author->type|lower }}){{ if !$gimme->current_list->at_end }}, {{ /if }}{{ /list_article_authors }} {{ list_article_locations }}{{ if $gimme->current_list->at_beginning }}/ {{ /if }}{{ if $gimme->location->enabled }}{{ $gimme->location->name }}{{ if $gimme->current_list->at_end }}{{ else }}, {{ /if }}{{ /if }}{{ /list_article_locations }}</span>
                  <!--add subhead-->
                {{ if $gimme->article->subtitles_count(full_text) gt 1 }} 
                    {{ list_subtitles field_name="full_text" }}
                        {{ if $gimme->current_list->at_beginning }}
                        {{ if !($gimme->article->full_text->has_previous_subtitles) }}
                        <figure>
                        {{ include file="_tpl/img/img_big.tpl" where="article" }}
                    </figure>
                        {{ /if }}
                        {{ /if }}
                    {{ /list_subtitles }}
                {{ else }} 
                 <figure>
                        {{ include file="_tpl/img/img_big.tpl" where="article" }}
                    </figure>
                {{ /if }}
                <!--add subhead-->
{{ if $gimme->article->content_accessible }}                       
                    {{ include file="_tpl/_edit-article.tpl" }}{{ $gimme->article->full_text }}
{{ else }}        
            <p><em>{{ #thisArticleIsLocked# }}</em></p>
{{ /if }}                     
                </article>
                <div class="paging-holder">
 <span class="paging">
                   {{ if $gimme->article->subtitles_count(full_text) gt 1 }}
   
        
            {{ list_subtitles field_name="full_text" }}
{{ if $gimme->current_list->at_beginning }}
{{ if $gimme->article->full_text->has_previous_subtitles }}
    <a href="{{ url options="previous_subtitle full_text" }}" class="prev"><span>+ {{ #previous# }}</span> {{ #page# }}</a>
{{ /if }}
{{ /if }}

<a href="{{ url }}" title="{{ $gimme->subtitle->name }}" {{ if ($gimme->article->current_subtitle_no(full_text)+1) == $gimme->current_list->index }} class="active"{{ /if }}>{{ $gimme->current_list->index }}</a>


{{ if $gimme->current_list->at_end }}
{{ if $gimme->article->full_text->has_next_subtitles }}
    <a href="{{ url options="next_subtitle full_text" }}" class="next"><span>{{ #next# }}</span> {{ #page# }} <span>+</span></a>
{{ /if }}
{{ /if }}

            {{ /list_subtitles }}
<a href="{{ uri options="all_subtitles full_text" }}" class="readAll">Read article on one page</a> 
{{ /if }}
    
</span>
                </div> 