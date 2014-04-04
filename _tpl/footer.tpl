      <div id="footer">
            
            <div id="bottom">
            
              <ul class="clearfix">
                  <li>
                      <ul>
         {{ set_current_issue }}    
          {{ list_sections }}       
          <li><a href="{{ url options="section" }}" title="{{ $gimme->section->name }}">{{ $gimme->section->name }}</a></li>
          {{ /list_sections }}                      
                      </ul>
                    </li>
                    <li>
                      <p>Rockstar Magazine<br />
                        Rockstreet 69 / 12345 Rocktown<br />
                        .+49 12 345 678 910</p>
                        <p><a href="mailto:email@rockstar-magazine.com">email@rockstar-magazine.com</a></p>
                    </li>
                    <li>
                      <ul>
          {{ unset_topic }}
          {{ list_articles ignore_issue="true" ignore_section="true" constraints="issue is 1 section is 5"}}
          <li><a href="{{ uri options="article" }}" title="{{ $gimme->article->name }}">{{ $gimme->article->name }}</a></li>
          {{ /list_articles }}
          <li><a href="#" class="show-feedback-form">Show Feedback</a></li>
                        </ul>
                    </li>
                    <li>
                      <p>&copy; {{ $gimme->publication->name }} {{ $smarty.now|camp_date_format:"%Y" }} - {{ #poweredBy# }}</p>
                        <ul>
          {{ list_articles ignore_issue="true" ignore_section="true" constraints="issue is 1 section is 15 type is link"}}
          <li><a target="_blank" href="{{ $gimme->article->url_address }}" title="{{ $gimme->article->name }}">{{ $gimme->article->name }}</a></li>
          {{ /list_articles }}                        
                        </ul>
                    </li>
                </ul>
            
            </div>
        
        </div>

        <div style="display:none">
    <div id="feedback-form">
      <!-- show only for logged in users -->
      {{ if $gimme->user->logged_in }}
        <div class="popup-form">
        <form method="POST" id="feedback-form-form" action="/feedback/save">
            <h2><span>Feedback</span></h2>
            <fieldset>
                <ul>
                    <li>
                        <select class="topic" style="min-width: 200px;">
                            <option value="First topic">First topic</option>
                            <option value="Second topic">Second topic</option>
                        </select>
                    </li>
                    <li>
                        <label>Subject</label>
                        <input type="text" id="feedback-subject" name="subject">
                    </li>
                    <li>
                        <label>Message<i>*</i></label>
                        <textarea cols="" rows="" id="feedback-content" name="content"></textarea>
                    </li>
                    <li class="input-file red">
                        <div class="show-value"></div>
                        <input type="file" class="upload" />
                    </li>
                    <li>
                        <small><i>*</i>Required</small></p>
                    </li>
                    <li class="top-line">
                        <div class="file-holder"></div>
                        <input type="submit" class="submit" value="Submit">
                    </li>
                </ul>
            </fieldset>
        </form>
        </div>
    {{ else }}
    <h2>Only for logged in users</h2>
    <p style="text-align: center; font-size: 15px; font-weight: bold; padding-top: 10px;">Login <a href="{{ $view->url(['controller' => 'auth', 'action' =>'index'], 'default') }}">here</a></p>
    {{ /if }}
    </div>
</div>