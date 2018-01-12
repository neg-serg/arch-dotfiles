@-moz-document domain('vk.com')
{
}

@-moz-document regexp('https?://vk\\.com/(?!dev/|dev$).*')
{
/*
=================================================*/

/*   Cream  |   Aqua  |  Green  |   Red   */
/*  #282828 | #2C2C36 | #2A2A2C | #2F353A */
/*  #222222 | #23232D | #212122 | #2b3034 */
/*  #191919 | #1D1D24 | #19191A | #262a2e */

/*  #B9B384 | #77BABC | #63b97f | #ff7b5d */
/*  #908B67 | #5B8E90 | #4B8B60 | #B35843 */

   /*[[sidebar_fixed]]*/
   /*[[input_minimize]]*/
   /*[[leave_redesign]]*/
   /*[[square_ava]]*/
   /*[[scrollbar_color]]*/
   /*[[birghtness_img]]*/
   /*[[mini_dialog]]*/

  body
  {
    background: url( /*[[user_bg]]*/ )  no-repeat fixed center 0;
    background-size: cover;
  }

   /*[[bg_img]]*/
/*======================background===========================*/


  ::selection
  {
    background-color: var(--color2);
    color: #ccc;
  }

  ::-moz-selection
  {
    background-color: var(--color2);
    color: #ddd !important;
  }

  .nim-dialog--name-w>span:first-child
  {
    font-weight: bold;
  }

/*header-1*/
  .page_name, .ui_rmenu_subitem.ui_rmenu_item_sel, .ui_rmenu_subitem.ui_rmenu_item_sel:hover, .ui_crumb, .box_title_wrap.box_grey .box_title, .ui_tabs_box .ui_tab_sel .ui_tab_count, .page_block_header, .mv_comments_summary, .mv_title, .im_stickerpack_name, .mv_recom_block .mv_recom_block_title, .videocat_channel_header .videocat_channel_title a, .pg_in:hover, .top_notify_header, .page_block_header_inner, .wall_module div.page_media_link_title, .im-submit-tt .im-submit-tt--title, input.text.ts_input:focus, .ui_suggester_results_list, .ui_suggester_results_list ul li.active, .ui_suggester_results_list ul li, .ui_suggester_results_list ul li.active, .ui_suggester_results_list ul li:hover, .im-page .im-page--peer, .lang_selected .lang_box_row_label, .blog_about_big_title, .ui_search_fltr_label, a.ui_box_header_link, h4, h1, h2, h3, .fans_idol_lnk, .reply_submit_hint_title, .gift_tt_header, #stats_cont h4, .stats_head, .docs_choose_attach, #all_shown, #feed_error_wrap, .im-dropbox, .exchange_subtab_cnt, .dark_box_label, .exchange_filter_label, .tickets_faq_title, .help_table_questions__title, .apps_access_item_info b, .settings_apps .app_settings_name, .settings_apps .app_settings_name a, .group_voting_title, .mott_header a, .video_upload_ready_name, .sticker_extra_tt .stickers_extra_text>b, .mott_header a, .verified_tt_header a, .flist_summary, .settings_activity_history tr th, .wk_sub_header, .wall_note_type,.medadd_c_linkimg_big .medadd_c_linkhead, .idd_popup .idd_header, .wpost_owner_head_name .wpost_owner_head_name_outer .wpost_owner_head_name_inner .wpost_owner_head_link, .cal_table .day.sel, .cal_table .day.sel.hover, .bd_day_head, .medadd_c_linkhead, .landing_vk2017_total, .landing_vk2017_promise_name a, .im-page--title-main-inner, .video_upload_progress .video_upload_progress_text, .payments_summary_header, .mv_donate_button.mv_donate_button, .blog_entry_title
  {
    color: #ddd;
  }

  .nim-dialog.nim-dialog_selected .nim-dialog--name-w  span, .page_media_poll .page_poll_row_count, .help_tile__title_a, .top_audio_player .top_audio_player_title, a.groups_messages_block:hover, .tickets_side_tt.text .hint_wrap, .ads_edit_value_header, .wk_header
  {
    color: #eee;
  }

/*header-2*/
  .module_header .header_top, .ui_rmenu_item_sel, .ui_rmenu_item_sel:hover, .search_header_text, .right_list_header, .subheader, h2, .mv_subscribe_block .mv_subscribe_btn_count, .wall_module div.page_media_link_desc, .box_grey .box_title .divider:before, .box_grey .box_title .tab_link, .box_grey .box_title .toggle, .box_grey .box_title .toggle a, .wdd_add3, #payments_box, .blog_about_company_stat_descr, .friends_phonebook .friends_field, .photos_edit_selection_header, .photos_container_edit_grid .photos_photo_edit_row_desc_placeholder, .prefix_input, .ui_search_fltr_sel .radiobtn, .ui_search_fltr_sep, .feedback_unread_bar, #exchange_comm_search_count, .blog_redesign_title, .ads_edit_link_type_item .ads_edit_link_type_item_title, .ads_edit_link_type_item.disabled .ads_edit_link_type_item_title, .ads_edit_link_type_item.disabled:hover .ads_edit_link_type_item_title, .settings_labeled_notice, .nim-dialog .nim-dialog--who, .nim-dialog .nim-dialog--name .nim-dialog--name-w, .im_sticker_bl_name, .search_filter_main, .search_filter_open, .search_filter_shut, .market_comments_summary, .market_item_title, .market_item_price, .im_stickers_my_name, .bd_name a, .audio_row.audio_row_current .audio_duration, .subheader, h4.subheader, .bv_title, .im-page .im-page--chat-search-empty, .pe_editor .pe_tabs .pe_tab.pe_selected .pe_tab_text, .help_tile_alert_urgent .help_tile_alert__title, .wk_external_content .wk_header, .wk_external_content .wk_sub_header, .wk_external_content .wk_sub_sub_header, a.groups_messages_block, a.wall_reply_greeting, .im-topic_dialog, .im-mess-stack .im-mess-stack--content .im-mess-stack--pname>a, .apps_options_bar .apps_options_bar_left .app_summary_name, .cal_table, .im-page_classic .im-page--top-notice .im-notice--title, .microdata_price, h2.payments_getvotes_title, .settings_votes_income .settings_history_amount, .feedback_header b, .feed_blog_reminder_title a, .group_al_title, .gtop_complex_message .gtop_content .gtop_header, .wk_sub_sub_header, .im-search--date-input .cal_table .today.day, #audio_status_tt .hint_title, .sticker_extra_tt .tt_text .stickers_extra_text>b, .pe_font_sample, .landing_vk2017_title, .post_header_info span .post_author span.author, .im-page--title-main-in, .nim-dialog:not(.nim-dialog_deleted).nim-dialog_hovered .nim-dialog--preview, .nim-dialog:not(.nim-dialog_deleted).nim-dialog_hovered .nim-dialog--text-preview, .nim-dialog:not(.nim-dialog_deleted).nim-dialog_unread.nim-dialog_classic .nim-dialog--preview, .nim-dialog:not(.nim-dialog_deleted).nim-dialog_unread.nim-dialog_classic .nim-dialog--text-preview, .nim-dialog:not(.nim-dialog_deleted):hover .nim-dialog--preview, .nim-dialog:not(.nim-dialog_deleted):hover .nim-dialog--text-preview, .nim-dialog:not(.nim-dialog_deleted).nim-dialog_hovered .nim-dialog--preview>b, .nim-dialog:not(.nim-dialog_deleted).nim-dialog_unread.nim-dialog_classic .nim-dialog--preview>b, .nim-dialog:not(.nim-dialog_deleted):hover .nim-dialog--preview>b, .im-page--title-main-inner, #marketplace .market_content .market_row.over .market_row_price, .post_author span.author, .mott_header, .promoted_post_tt .header, .verified_tt_header, .wall_tt .header, .right_list_field.right_list_field__common_text, .wl_replies_header, .market_row_name a, .page_market_album_title_text, .audio_section_promo__title, .audio_page_layout .audio_recoms_blocks .recoms_special_block_title, .audio_page_layout .audio_section__recoms .recoms_special_block_title, .audio_pl_snippet .audio_pl_snippet__info_title, .blog_entry_author_name, .audio_pl_snippet .audio_pl_snippet__info_author>a, .audio_w_covers .audio_row .audio_row__title, .im-page .im-search-results-head, .audio_page__shuffle_all .audio_page__shuffle_all_button, .article>h2, .blog_entry_text b
  {
    color: #aaa;
  }

  input.text.ts_input
  {
    background-image: url('https://i.imgur.com/7zTLJDm.png');
  }

  .search_filters_minimized_text
  {
    background-image: url('https://i.imgur.com/oe31uPB.png');
    background-color: #222;
  }

  #ads_left, .emoji_expand_shadow, .emoji_expand_shadow_top, .emoji_tabs_l_sc, .emoji_tabs_r_sc, .chat_cont_sh_bottom, .chat_cont_sh_top, .leave_redesign, .ui_scroll_default_theme.ui_scroll_emoji_theme .ui_scroll_shadow_bottom, .ui_scroll_default_theme.ui_scroll_emoji_theme .ui_scroll_shadow_top, embed#flash_api_external, .emoji_cats_title_helper:after, ._ads_promoted_post_data_w
  {
    display: none !important;
  }

  .button_gray button.hover, .button_gray button:hover, .flat_button.secondary.hover, .flat_button.secondary:hover, .box_controls .flat_button.secondary:hover, .flat_button.secondary.button_light:hover, #mv_comments_header:hover, .mv_subscribe_block .mv_subscribe_btn_count, .replies_open, .wr_header:hover, .top_notify_show_all:hover, .pv_comments_header:hover, em.ts_clist_hl, em.highlight, .search_focused .highlight, .audio_search_focused .audio_performer>em, .audio_friend.audio_friend_selected, .ui_toggler:after, .summary_tab2:hover
  {
    background-color: var(--color7);
  }

  .ui_tab_sel, .ui_tabs .ui_tab_sel, .ui_tabs_box .ui_tab_sel, body, .page_block, #page_header_cont .back, .fakeinput, div[contenteditable=true], input.big_text, input.dark, input.search, input.text, textarea, .profile_more_info_link:hover, .top_nav_btn:hover, .top_nav_link:hover, .submit_post, .button_gray button, .flat_button.secondary, .top_nav_link, .tt_default, .tt_default_right, input.ui_search_field, .box_controls .flat_button.secondary, .flat_button.secondary.button_light, ul.listing li span, .audio_page_player .audio_page_player_title, #mv_comments_header, .replies_open, .wr_header, .wall_reasons_list, .wall_reply_text, .bd_header_info, .audio_row .audio_title_wrap, .page_actions_dd_label, .page_actions_header_inner, #mail_box_editable, .nim-dialog.nim-dialog.nim-dialog_selected:hover, .im-page .im-page--center-empty, .olist.audio_album .olist_item_title, .pv_comments_header, .ui_suggester_results_list ul li.active, #pv_tags span, .flat_button, .ui_multiselect_cnt .token .token_title,  .tabbed_box .summary_tab_sel:hover nobr, .ui_tab, .ui_tabs .ui_tab, .ui_rmenu_subitem, .flat_button.secondary:hover, .page_media_poll .page_poll_row_percent, .payments_getvotes_method_opt, .blog_about_company_descr, .blog_snapster_descr, .photos_container_edit_grid .photos_photo_edit_row_desc_input:focus, .photos_container_edit_grid .photos_photo_edit_row_desc_input, .photos_container_edit_grid .photos_photo_edit_row_desc_placeholder.photos_edit_has_desc, .selector_container td.selector .token, .result_list ul, .result_list ul li.active, .result_list ul li, #mv_pl_tt .mv_tt_playlist, .privacy_dropdown .header, .wall_module .media_desc .lnk .lnk_mail_description, .owner_photo_additional, .nim-dialog.nim-dialog_typing .nim-dialog--typing, .nim-dialog.nim-dialog_typing .nim-dialog--typer-el, .feedback_content .feedback_text .wall_post_text, .feedback_content .feedback_text .wall_reply_text, .feedback_sticky_text, #audio_status_tt .audio_status_wrap, .reply_submit_hint_opts .radiobtn, .blog_entry_text, div.fc_editable~.placeholder .ph_content, .checkbox, .feedback_content .feedback_text, .like_share_radio .wdd_text, .audio_row .audio_lyrics, .feed_notifications .more_link, #ads_page_title b, .exchange_subtab1:hover, .exchange_subtab1, .page_group_desc, .box_msg, .wdd_text, .flat_button.secondary_dark, .profile_warning_label, #video_playlists_edit_box .pl_size, .tt .tt_text, .top_notify_cont .feedback_header, .tickets_side_tt.title .hint_wrap, .tickets_tt_list, .tickets_tt_list_abuse, .notify_tt_text, .ads_edit_link_type_item .ads_edit_link_type_item_description, .ads_edit_link_type_item.disabled .ads_edit_link_type_item_description, .ads_edit_link_type_item.disabled:hover .ads_edit_link_type_item_description, .tickets_reply_text, .tickets_post_field_wrap, .tu_row_comment, .help_tile__title_a, .help_table_questions__title, .help_table_not_found_text__p, .help_table_question_act, .page_list_module .group_desc, .page_list_module .people_desc, .page_list_module .people_extra, .profile_info .label, .profile_label_link, .page_counter .label, .group_row_info, .login_mobile_info, .fakeinput~.placeholder .ph_content, div[contenteditable=true]~.placeholder .ph_content, input.big_text~.placeholder .ph_content, input.dark~.placeholder .ph_content, input.search~.placeholder .ph_content, input.text~.placeholder .ph_content, textarea~.placeholder .ph_content, a.ui_crumb, .nim-dialog .nim-dialog--preview, .friends_field, .pv_cont .pv_comments_header, .pv_cont .pv_comments_header:hover, .sticker_extra_tt .tt_text, .subscribe_post_tt .tt_text, .login_about_mobile, .photos_choose_more, .photos_choose_more_albums, .dropbox_area, .pe_type_chooser_item, .pe_params_slider_label, .selector_container td.selector .token_inner, .selector_container td.selector .token_prefix, .ads_edit_tt_text, .audio_row:not(.audio_row_current):hover .audio_title_wrap, .search_row .labeled, .fc_msgs, .market_comments_header, .post_media_link_preview_wrap .wall_postlink_preview_btn_disabled .post_media_link_preview_disabler, .feedback_header, .photos_album_intro .photos_album_intro_desc, .nim-dialog .nim-dialog--date, .ui_ownblock_hint,  li.nim-dialog._im_dialog:hover .nim-dialog--preview, div#wpost_post_actions_wrap .post_comments, div#wpost_post_actions_wrap .post_like, div#wpost_post_actions_wrap .post_reply, div#wpost_post_actions_wrap .post_share, .ui_rmenu_count.ui_rmenu_count_grey, .nim-dialog:not(.nim-dialog_deleted).nim-dialog_unread.nim-dialog_classic .nim-dialog--preview, .tickets_thank_you_form__inner, .tickets_thank_you_form__title, .nim-dialog:not(.nim-dialog_deleted).nim-dialog_muted.nim-dialog_selected .nim-dialog--unread, .nim-dialog:not(.nim-dialog_deleted).nim-dialog_selected .nim-dialog--unread, .settings_label, .profile_no_info .labeled, .cal_table .daysofweek, .validation_devices_wrap .radiobtn, .validation_row .radiobtn, .im-page_classic .im-page--top-notice .im-notice--text, .payments_getvotes_amounts .radiobtn b, .bd_day_num, .gtop_complex_message .gtop_content .gtop_message, .blst_other, .medadd_c_linkdsc, .feed_wrap .explain, .im-search--date-input .cal_table .past_day.day, .ui_search_sugg_list .ui_search_sugg_list_item, .feed_update_row .post_author, .feed_groups_hidden_list_show_btn, .im-fwd.im-fwd_msg .im-fwd--messages, .right_list_field right_list_field__common_text right_list_field--live, #marketplace .market_content .market_row .market_row_user .market_row_user_link, #marketplace .market_content .market_row .market_row_address, #marketplace .market_content .market_row .market_row_time, .mail_box_group_first_message, .wall_module .post_views, .bt_report_sidebar_wrap, .group_help_desc, #share_cont .radiobtn, #share_cont .checkbox_label, .audio_pl_snippet .audio_pl_snippet__description, .audio_page_layout .audio_item__title, .audio_page_layout .audio_item__title>a, .stories_feed_item_name, .feed_blog_reminder_large .feed_blog_reminder_text, .audio-msg-track.audio-msg-player .audio-msg-track--duration, .audio_pl__followed .audio_pl_snippet_follow, .mv_live_gifts_supercomment, .audio_pl_snippet .audio_pl_snippet__info_line, .shorten_list_stats_value, .audio_row .audio_row__lyrics .audio_row__lyrics_inner, .post_from_tt_row, .wddi_over .wddi_sub, .nim-dialog.nim-dialog_classic.nim-dialog_unread-out.nim-dialog_muted .nim-dialog--inner-text, .nim-dialog.nim-dialog_classic.nim-dialog_unread-out .nim-dialog--inner-text, .app_widget_list_title, .app_widget_list_text, .im-chat-input--editing-head, .article
  {
    color: var(--color6);
  }

  .im-chat-input .im-chat-input--text *, .lang_column b
  {
    color: var(--color6) !important;
  }

  .wd_lnk, .wall_module .published_by_date, .wall_module .wall_post_source, .im-mess-stack .im-mess-stack--tools a, .im-mess-stack .im-mess-stack--tools, .wall_module .reply_date, .post_date, .post_date .post_link, .post_date .wall_text_name_explain_promoted_post, .wall_module .reply_to, .fc_msgs .audio_inline_player .slider .slider_slide, .friends_field .group_link, .mention_tt_extra, .mention_tt_extra a, .fc_msgs .audio_row:not(.audio_row_current):hover .audio_title_wrap, .wall_module .reply_fakebox, a.bp_date, .im-page .im-page--lastact, .tabbed_box .summary_tab .summary_tab3 span, .tabbed_box .summary_tab_sel .summary_tab3 span, .im-mess-stack .im-mess-stack--content .im-mess-stack--tools, .im-mess-stack .im-mess-stack--tools, .im-mess-stack .im-mess-stack--tools a._im_mess_link, .im-mess-stack .im-mess-stack--content .im-mess-stack--tools a, .datepicker_text, .im-mess-stack .im-mess-stack--content .im-mess-stack--pname, .cal_table .past_day, .validation_device_notice, .blst_other, .im-search--date-input .cal_table .day, .page_friend_reply_date, .feedback_date .post_link, .feedback_date, .im-page--members, .audio_w_covers .audio_row .audio_row__performer, .audio_row .audio_row__duration, .audio_pl_snippet .audio_pl_snippet__stats, .post_header_info .explain, .post_author, .wall_module .reply_author, .im-mess.im-mess_srv .im-mess--text, .im-mess .im-mess--text .im_srv_lnk, .im-mess .im-mess--text .im_srv_mess_link, .im-mess--lbl-was-edited
  {
    color: var(--color8);
  }

  .ui_header_ext_search
  {
    color: #92A9C5;
  }

  .idd_wrap .idd_arrow
  {
    color: #738da8;
  }


/*======================background===========================*/

/*-bgdark-*/

  .ui_tabs.ui_tabs_sliding:before, .button_blue button.hover, .button_blue button:hover, .flat_button.hoverr, .ui_rmenu_sliding:before, .audio_inline_player .slider .slider_amount, .audio_page_player .slider .slider_amount, .audio_inline_player .slider .slider_handler, .audio_page_player .slider .slider_handler, .slider_hint, .scrollbar_hovered, .scrollbar_inner:hover, .im-mess.im-mess_unread .im-mess--marker, .nim-dialog.nim-dialog_selected, .nim-dialog.nim-dialog.nim-dialog_selected:hover, .nim-dialog:hover+.nim-dialog.nim-dialog_selected, .top_nav_btn.active, .nim-dialog.nim-dialog_unread-out .nim-dialog--unread, .nim-dialog.nim-dialog_unread.nim-dialog_unread-out .nim-dialog--unread, .tabbed_box .summary_tab_sel .summary_tab2, .left_count_wrap, .nim-dialog.nim-dialog_unread .nim-dialog--unread, .nim-dialog.nim-dialog_unread.nim-dialog_prep-injected .nim-dialog--unread, .fc_clist_online:before, .ui_toggler.on:after, .summary_tab_sel .summary_tab2, .summary_tab_sel .summary_tab2:hover, .ui_search_filters_pane .token, .ui_tab_group.ui_tab_group_sel:before, .pr_bt, .audio_progress, .layers_shown .chat_tab_wrap:hover, .layers_shown .chat_tab_online_icon, .nim-dialog.nim-dialog_muted.nim-dialog_selected, .nim-dialog.nim-dialog_selected, .top_nav_btn.active:hover, .nim-dialog.nim-dialog_unread.nim-dialog_muted .nim-dialog--unread, .nim-dialog:not(.nim-dialog_deleted).nim-dialog_muted.nim-dialog_selected, .nim-dialog:not(.nim-dialog_deleted).nim-dialog_selected, .ui_rmenu_sliding .ui_rmenu_slider, .nim-dialog.nim-dialog_starred:before, .fc_msgs .audio_inline_player .slider .slider_amount, .pe_type_chooser_item.selected, #im_dialogs > li.nim-dialog._im_dialog._im_dialog_12093114.nim-dialog_unread-out > div.nim-dialog--content > div > div.nim-dialog--unread._im_dialog_unread_ct, .nim-dialog .nim-dialog--unread, .nim-dialog.nim-dialog_unread-out:not(.nim-dialog_failed) .nim-dialog--unread, .audio_progress, .im-audio-message-input .im-audio-message--send-btn:hover, .audio-msg-track .audio-msg-track--btn, .nim-dialog.nim-dialog_unread-out.nim-dialog_muted:not(.nim-dialog_failed) .nim-dialog--unread, a.group_app_button:hover:after, .audio_section_promo__close:hover, .round_button:hover
  {
    background-color: var(--color1);
  }

  .button_blue button, .button_gray button, .button_light_gray button, .audio_inline_player .slider .slider_back, .audio_page_player .slider .slider_back, .scrollbar_inner, .top_audio_player.audio_top_btn_active, .im-mess.im-mess_unread.im-mess_sending .im-mess--marker, a:hover .left_count_wrap, .button_blue button.hover, .button_blue button:hover, .flat_button.hover, .flat_button:hover, .ui_toggler.on, .selector_container td.selector .token_hover, .pv_narrow_column_wrap, .audio_progress_wrap, .chat_tab_wrap:hover, .emoji_bg, .emoji_tab:hover, .emoji_sticker_item:hover, .video_item_title em, .wdd_hl, .page_media_poll .page_poll_percent, .im-dropbox--release, .exchange_subtab1.active, .exchange_subtab1.active:hover, .ads_nav .nav_selected, .ads_nav .nav_selected:hover, .nav_selected:hover, .flat_button.secondary_dark:hover, .ads_edit_link_type_item.selected, .ads_edit_link_type_item.selected.disabled, .ads_edit_link_type_item.selected.disabled:hover, .ui_tabs.ui_tabs_sliding .ui_tabs_slider, .ui_rmenu_count, .fc_msgs_out .fc_msgs, .fc_msgs .audio_row.audio_row_playing:hover, .fc_msgs .audio_row.audio_row_current:hover, .away_head, .flat_button.secondary .pr_bt, .flat_button.secondary_dark .pr_bt, .cal_table .month, .cal_table .month_arr, .cal_table .day.sel, .cal_table .day.sel.hover, .cal_table .day.hover, .ui_scroll_default_theme .ui_scroll_bar_container:hover>.ui_scroll_bar_outer>.ui_scroll_bar_inner, .ui_scroll_default_theme.ui_scroll_dragging>.ui_scroll_bar_outer>.ui_scroll_bar_inner, .olist_item_wrap em, .bd_day_head, .ts_contact.active em.ts_clist_hl, .nim-dialog:not(.nim-dialog_deleted).nim-dialog_selected, .nim-dialog:hover+.nim-dialog.nim-dialog_selected, .nim-dialog:hover, .nim-dialog.nim-dialog_hovered, .nim-dialog.nim-dialog.nim-dialog_selected:hover, .nim-dialog:not(.nim-dialog_deleted).nim-dialog_muted.nim-dialog_selected, .left_count_wrap.left_count_wrap_hovered:hover, a.group_app_button:after, .flat_button.ui_load_more_btn:hover, .feed_new_posts>b, .audio_section_promo__link, .round_button, .post_from_tt_row.active, .wddi_over .wdd_hl
  {
    background-color: var(--color2);
  }

  .profile_more_info_link:hover, .top_nav_btn:hover, .top_nav_link:hover, .button_gray button, .flat_button.secondary, .my_current_info:hover, .no_current_info:hover, .fakeinput:focus, input.big_text:focus, input.dark:focus, input.search:focus, input.text:focus, textarea:focus, .media_selector .ms_items_more .ms_item:hover, .ui_rmenu_item_sel, .ui_rmenu_item_sel:hover, .ui_rmenu_item:hover, .ui_rmenu_subitem:hover, .ui_rmenu_item_sel, .ui_rmenu_item_sel:hover, a.ts_contact.active, a.ts_search_link.active, .audio_inline_player .slider .slider_slide, .audio_page_player .slider .slider_slide, .ui_actions_menu_item:hover, .wall_module .post_like:hover, .wall_module .post_share:hover, .ui_tabs.ui_tabs_box, .box_body, div.wdd.wdd_focused, div.wdd.wdd_focused input, .page_block_header, #pv_author_block, .pv_like:hover, .box_title_wrap.box_grey, .box_title_wrap.box_grey .box_title, .ui_tabs_header, .friends_import_row:hover, .top_profile_mrow:hover, .flat_button.secondary, .tt_default, .tt_default_right, input.ui_search_field, .box_controls .flat_button.secondary, .audio_friend:hover, .box_title, .box_title_wrap, #mv_comments_header, .web_cam_photo:hover, .photos_choose_upload_area:hover, .photo_upload_separator, .im_stickers_buy_header, .replies_open, .wr_header, .blst_last:hover, .top_notify_header, .top_notify_show_all, .pv_can_edit:hover, .audio_row.audio_row_current, .audio_row.audio_row_playing, .audio_row.audio_row_playing:hover, .top_audio_player:hover, .ui_actions_menu_sublist .ui_actions_menu_item.checked:hover, .docs_choose_upload_area:hover, #mail_box_editable:focus, .im-mess.im-mess_selected, .im-mess.im-mess_selected:hover, .nim-dialog:hover, .wl_post_reply_form_forbidden, .wall_module .reply.reply_highlighted, .wl_replies_header, .wl_replies_header_progress, .im-mess.im-mess_search:hover, .im-mess.im-mess_light, .olist_item_wrap:hover, input.text.ts_input:focus, .pv_comments_header, .tabbed_box .summary_tab .summary_tab3:hover, .tabbed_box .summary_tab_sel .summary_tab3:hover, .tabbed_box .summary_tab_sel a:hover, .tabbed_box .summary_tab a:hover, .fc_msgs, .fc_msgs_unread, .fc_tab_head, a.fc_contact_over, .ui_suggester_results_list:hover, .ui_suggester_results_list ul li.active, .ui_suggester_results_list ul li:hover, .im-create .im-create--tabs, .nim-dialog.nim-dialog_simple:hover, .flat_button, .ui_toggler, .ui_multiselect_cnt .token, .ui_grey_block, .mv_desc .can_edit:hover, .feed_new_posts:hover, .ui_actions_menu_item.feed_new_list:hover, .gifts_box_header, .wdd_add2, .payments_getvotes_method_opt.payments_getvotes_active_row, .payments_getvotes_method_opt:hover, .page_actions_header, .page_actions_item:hover, .wall_comments_header, .settings_line.unfolded, .settings_block_footer, .lang_box_row:hover, .blog_job:hover, .blog_about_company_stats, .blog_about_press, .wk_poll_tabs, .photos_edit_selection_header, .photos_container_edit_grid .photos_photo_edit_row_desc_input:focus, .selector_container td.selector .token, .result_list ul li:hover, .result_list ul li.active, #mv_pl_tt .mv_tt_add_playlist:hover, .privacy_dropdown .item_sel, .privacy_dropdown .item_sel_plus, .privacy_dropdown .header, .idd_popup .idd_header_wrap, .idd_popup .idd_item.idd_hover, .idd_popup .idd_item.idd_hover_sublist_parent, .im-page .im-page--mess-search:hover, .photos_container_edit_grid .photos_restore, .prefix_input_prefix, .prefix_input, .group_activity_row_wrap .group_obscene_word, .bp_post.bp_selected.bp_animated , #audio_status_tt .audio_share_cont, .info_msg, .friends_cur_filters .token, .idd_popup .idd_item.idd_hl, .public_help_steps_module .public_help_steps_link:hover, .medadd_c_linkcon, .feedback_sticky_row.unread, .top_notify_cont .feedback_row_clickable.unread:hover, .top_notify_cont .feedback_row:hover, .feedback_sticky_row:hover, .im-mess.im-mess_unread, .im-mess.im-mess_selected:last-child:before, .im-mess.im-mess_unread:last-child:before, .im-mess.im-mess_selected+.im-mess:before, .im-mess.im-mess_unread+.im-mess:before, .im-page .im-page--history-new-bar:after, .im-page .im-page--history-new-bar:before, .emoji_tabs, .emoji_tab_sel, .emoji_tab_sel:hover, .emoji_tabs_l_s:hover, .emoji_tabs_r_s:hover, .emoji_tt_wrap, .emoji_tabs_l_s, .emoji_tabs_r_s, .im_rc_emojibtn:hover, .bp_post.bp_selected, .chat_tab_typing_wrap, .ui_actions_menu_item.feed_custom_list:hover, .gift_tt_show_all:hover, .post_upload_dropbox, .wk_text blockquote, .ui_gridsorter_cont .ui_gridsorter_moveable, .docs_choose_rows .docs_item:hover, .page_media_poll .page_poll_row, .feedback_row_wrap.unread .feedback_photo_icon, .feedback_like_row .feedback_photo_icon, .top_notify_cont .feedback_row:hover .feedback_photo_icon, .top_notify_cont .feedback_row:hover .feedback_photo_icon, .feedback_followers_row .feedback_photo_icon, .feedback_publish_row .feedback_photo_icon, .feedback_reply_row .feedback_photo_icon, .wl_replies_header.wl_replies_header_clickable:hover, .docs_panel, .top_notify_cont .feedback_img, .wddi_no, .nim-dialog.nim-dialog_hovered, .nim-dialog:hover, .wddi_over .wddi_data, .chat_tab_wrap:hover .chat_tab_typing_wrap, textarea.page_poll_export_code, .feed_notifications .more_link, .top_nav_link.active, #ads_page_title, .ads_main_notice, .exchange_table th, .exchange_table tr.even, #ads_page_bottom_info, .exchange_subtab1:hover, .ads_nav .nav:hover:not(.nav_selected), .exchange_ad_post_club_commment:hover, a.exchange_ad_post_link:hover, a.exchange_ad_post_stats:hover, #dark_box_topic_wrap, .faq_tabs.ui_tabs, .tickets_faq_row.over, .help_table_question, .help_table_question_visible, .apps_i_policy, .box_msg, .msg, .group_u_photo.online.mobile:after, .flat_button.secondary_dark, .post_upload_dropbox.dropbox_over .post_upload_dropbox_inner, .group_api_blockquote, .video_item .video_restore, .group_wiki_hider:hover, .nim-dialog:not(.nim-dialog_deleted).nim-dialog_hovered, .nim-dialog:not(.nim-dialog_deleted):hover, .ui_ownblock:hover, .feedback_sticky_row.hover, .feedback_sticky_row:hover, .flist_item_wrap:hover, .im-page a.im-page--back-button:hover, .ads_edit_link_type_item:hover, .sticker_hints_arrow, .sticker_hints_arrow:hover, #pv_friends .list_wrap a:hover, .search_row .online.mobile:after, .vkmenu ol li a:hover, .audio_filter.download_controls.layout-post-2016 > div.label:hover, .nim-dialog:not(.nim-dialog_deleted).nim-dialog_unread.nim-dialog_classic, .feedback_row_wrap.unread:not(.feedback_row_touched), .top_notify_cont .feedback_row:not(.dld):hover, .photos_container_albums .photos_album_thumb, .video_item .video_item_thumb_wrap, .video_playlist_item .video_playlist_item_thumb_wrap, .videocat_featured_playlist, .videocat_featured_video, .im-page .im-page--top-date-bar-inner, #profile_groups_link:hover, .photos_choose_row .photo_row_img, .pv_cont .pv_comments_header, .pv_cont .pv_comments_header:hover, .pv_cont .pv_can_edit:hover, .dropbox_over .photos_choose_upload_area_drop, .photos_choose_upload_area_enter .photos_choose_upload_area_drop, .photos_choose_more, .photos_choose_more_albums, .photos_choose_more:hover, .photos_choose_more_albums:hover, .im_stickers_my_tip, .pe_tabs_panel, .ui_scroll_default_theme .ui_scroll_bar_inner, .audio_row:not(.audio_row_current):hover, .ui_scroll_default_theme.ui_scroll_dragging .ui_scroll_bar_inner, .market_comments_header, .market_like:hover, .market_share:hover, .post_media_link_preview_wrap .wall_postlink_preview_btn_disabled .post_media_link_preview_disabler, .pe_editor .pe_sticker_preview:hover, .pe_editor .pe_sticker_packs_tabs, .im-chat-input.im-chat-input_error, .mbe_rc_emojibtn:hover, div#wpost_post_actions_wrap .post_comments:hover, div#wpost_post_actions_wrap .post_like:hover, div#wpost_post_actions_wrap .post_share:hover, .audio_row.audio_row_current:hover, .cal_table .daysofweek, .ui_progress .ui_progress_back, .piechart_col_header th, .im_msg_audiomsg .audio-msg-track:not(.audio-msg-player):hover, #payments_box.payments_box_votes .payments_box_promo_descr, .payments_getvotes_ps_row.payments_getvotes_active_row, .payments_getvotes_ps_row:hover, .payments_offer_row:hover, .im-page .im-page--top-date-bar:before, .nim-dialog.nim-dialog_classic.nim-dialog_unread-out .nim-dialog--inner-text, .nim-dialog.nim-dialog_classic.nim-dialog_unread-out.nim-dialog_muted .nim-dialog--inner-text, .bd_day_cell.holiday, .bd_day_cell.holiday.today, .bd_day_cell.today, .bd_arrow, .im-page .im-page--top-date-bar.im-page--date-bar-transition.im-page--date-bar-transition-inverse, .emoji_cat_title, .ui_search_new.ui_search_dark .ui_search_input_inner, .ui_search_sugg_list, .im_cal_clear, .ui_search_new .ui_search_button_search, .feed_groups_hidden_list_show_btn, .nim-dialog.nim-dialog_classic:not(.nim-dialog_deleted).nim-dialog_hovered.nim-dialog_unread-out .nim-dialog--inner-text, .im-create .im-creation--item.im-creation--item_hovered, .im-create .im-creation--item:hover, .top_notify_cont .feedback_content .audio_row:hover, #mv_warning, .video_upload_separator_line, .im-page--back-btn:hover,.im-page--back-btn:hover, .nim-peer.nim-peer_smaller.online.mobile:after, #marketplace .market_content .market_row.over, .nim-dialog:not(.nim-dialog_deleted).nim-dialog_hovered .nim-dialog--photo .online.mobile:after, .nim-dialog:not(.nim-dialog_deleted).nim-dialog_unread.nim-dialog_classic .nim-dialog--photo .online.mobile:after, .nim-dialog:not(.nim-dialog_deleted):hover .nim-dialog--photo .online.mobile:after, .im-page--chat-header, .flat_button.ui_load_more_btn, .wall_module .post_reply:hover, .video_upload_tc_wrap .video_tc_upload_btn:hover, #group_apps_wrapper .ui_tabs_header, .bt_report_sidebar_wrap_dark, .share_head, .audio_layer_container .audio_friend:hover, .audio_row.audio_row_current .audio_row_inner, .audio_row.audio_row_playing .audio_row_inner, .audio_row.audio_row_current .audio_row_inner:hover, .audio_row.audio_row_playing .audio_row_inner:hover, .audio_row:not(.audio_row_current):hover .audio_row_inner, .audio_page_layout .audio_page_separator, .ui_actions_menu._ui_menu:hover, .audio_pl_item .audio_pl__cover, .audio_pl_snippet .audio_pl_snippet__cover, .audio_pl_attach_preview, .audio_pl_edit_box .ape_pl_item:hover, .im-audio-message-input, .audio_pl__followed .audio_pl_snippet_follow, .mv_live_gifts_item:hover, .mv_live_gifts_arrow_left:before, .mv_live_gifts_arrow_right:before, .audio_pl_edit_box .ape_add_audios_btn:hover, .audio_pl_edit_box .ape_add_pl_audios_btn:hover, .pv_cont .pv_reply_form_wrap, #audio_status_tt .audio_status_sep, .audio_row.audio_row__current .audio_row_content, .audio_row:hover:not(.audio_row__current) .audio_row_content, .audio_row__more_actions .audio_row__more_action:hover, .audio_w_covers .audio_row.ui_gridsorter_moveable .audio_row_content, .ap_layer .audio_pl_snippet .audio_pl_snippet__header_inner, .post_from_tt_row:hover, .im-mess.im-mess_unread:not(.im-mess_light), .header.ytd-playlist-panel-renderer, .wall_module .post_dislike:hover, .feed_block_article:hover, .im-mess.im-mess_selected:not(.im-mess_is_sebastianoving), .im-mess.im-mess_selected:not(.im-mess_is_sebastianoving):hover, .im-dropbox--rect.dropbox_over, .audio_page__shuffle_all .audio_page__shuffle_all_button:hover, .im-mess.im-mess_was_edited.im-mess_unread.im-mess_nobg
  {
    background-color: var(--color3);
  }

  .im-mess.im-mess_gift.im-mess_selected, .im-mess.im-mess_gift.im-mess_selected:hover, #side_bar ol li .left_row:hover, #side_bar ol li:hover, .idd_popup .idd_item:active, .lang_column a[style*='FFF8CC'], paper-button.ytd-subscribe-button-renderer[subscribed]
  {
    background-color: var(--color3) !important;
  }

  .page_block, #page_header_cont .back, #side_bar ol li .left_row:hover, .fakeinput, div[contenteditable=true], input.big_text, input.dark, input.search, input.text, textarea, .profile_info_header, .page_status_editor .editor, .ms_items_more, .ts_cont_wrap, .profile_info_header_wrap a, .stl_active.over_fast #stl_bg, .ui_actions_menu, .wall_module .reply_fakebox, .submit_post, .like_share_wrap, div.wdd, .like_share_radio .wdd_text, .wddi_data, .pv_cont .narrow_column, input.ui_search_field, .mott_header, .promoted_post_tt .header, .verified_tt_header, .tt_default, .tt_default_rightr, .friends_search_filters, .friends_search_import, #top_profile_menu, .audio_page_player, .audio_friends_list, .mv_wide_column, .mv_controls, .photos_choose_upload_area, .web_cam_photo, .photos_choose_bottom, .wall_tt .like_tt_bottom, .ba_post, #top_notify_wrap, .feedback_row_answer, .top_audio_layer .audio_layer_rows_cont, .audio_layer_bottom, .pv_white_bg, .docs_choose_upload_area, .mail_box_cont, #mail_box_editable, .mention_tt_actions, .im-chat-input, .im-chat-input .im-chat-input--text, .im-page .im-page--dialogs-footer.ui_grey_block, #wk_box, .eltt, .box_body, #album_name_wrap, .im-page .im-page--history-new-bar, .fc_tab, div.fc_tab_txt, .chat_onl_inner, #fc_contacts, .fc_content, div.fc_clist_filter_wrap, .layers_shown .chat_onl_inner, .ui_suggester_results_list ul li.active, .ui_suggester_results_list, .fc_tab_notify, .im-create .im-create--dcontent, .im-create .im-create--table>div, .im-create, .ui_search_input_block, #payments_box .payments_about_votes, .page_actions_inner, .blog_jobs_page, .blog_jobs_page .footer_wrap, .blog_about_page .footer_wrap, .blog_about_page .footer_wrap, .wk_poll_dmgr, .wk_extpage_footer_wrap, .photos_container_edit_grid .photos_photo_edit_row_desc_placeholder,.selector_container, .result_list ul, #mv_pl_tt .mv_tt_add_playlist, .privacy_dropdown, .idd_popup .idd_items_content, .im-page .im-page--mess-search, .im-page .im-page--header, .photos_go_to_album, .photos_period_delimiter_fixed, .group_l_row, .ui_search_fltr, .pva_period_fixed, .preq_wrap, .owner_photo_additional, .feedback_row_wrap.unread, .wall_module .page_media_thumbed_link, body div.fc_editable:focus, .feedback_row_wrap.reply_box_open, .feedback_row_wrap.reply_box_open .submit_post, .feedback_row_wrap.reply_box_open:hover, .feedback_unread_bar, .video_choosebox_bottom, .emoji_tabs_wrap, .feed_row~.feed_row .feedback_row_clickable:not(.feedback_row_touched):hover, .feedback_row_clickable:not(.feedback_row_touched):hover, .pv_reply_form_wrap, .gift_tt_show_all, .page_media_poll_wrap, .ui_search_filters_pane, .friends_photo_img, .docs_choose_dropbox_wrap, .im-dropbox, #ads_page, .exchange_not_found.table, #exchange_comm_search_filters, .dark_box_cont, .help_table_question, .apps_i_panel, .apps_i_wrap, .wk_text.wk_wiki_content.wk_nano_content, .search_item_img, .ads_edit_page_wrap3, .feedback_sticky_img, .payments_transfer_to_photo, .wke_page_title_cont, .wke_controls, .photos_container .photos_row, .tt .tt_text, .im-page.im-page_group .im-page--dcontent, .im-page.im-page_group .im-page--chat-body-wrap-inner, .im-page.im-page_group .im-page--header-inner, .flist_sel, .im-page.im-page_classic .im-page--dcontent, .im-page.im-page_classic .im-page--chat-body-wrap-inner, .im-page.im-page_classic .im-page--header-inner, .tt_w.top_notify_tt, .sticker_hints_tt, #pv_friends, #pv_friends, .im-page .im-page--header, .im-page .im-page--search-header, .page_album_thumb_wrap, .tickets_thank_you_form_undo, .page_block .ui_tabs_subheader, .tickets_suggest__title, .tickets_suggests_wrap, .help_table_question, .tu_last:hover, .tickets_suggest:hover, .tickets_suggests_all_results:hover, .disabled.selector_container, .post-2016-layout .mono-block, .help_table_question__acts .help_table_question_act_ok, .help_table_question_act:hover, .vkmenu ol li a, .vkmenu ol li:hover, .audio_filter.quality_filter.layout-post-2016.append, .ui_search, .pv_author_block, .im-page .im-page--history-new-bar>span, .login_about_mobile, .photos_choose_upload_area_enter .photos_choose_upload_area, .dropbox, .im_stickers_store_wrap .ui_tabs, .im_stickers_bl_wrap, .im_sticker_bl, .wk_table th, .wall_module .reply_box, .wall_module .reply_fakebox_wrap, .wall_module .reply_form, .market_item_photo_container, .market_item_content, .pe_main_wrap, .pe_editor .pe_bottom_actions, .settings_blb_row, .mv_info, .feedback_img, img.fans_idol_img, .privacy_dropdown .body, ._audio_rows_header.audio_rows_header.fixed, #shorten_short, #wpost_post, .apps_options_bar, .apps_footer, .tickets_thank_you_form__inner, .tickets_thank_you_form__title, .join_box_content, .tickets_thank_you_form, .cal_table, .validation_readonly_wrap, .validation_row input.validation_readonly, .im-page_classic .im-page--top-notice, .im-page .im-page--dialogs.im-page--dialogs-notice .im-page--header, .apps_main .apps_i_panel, .upload_progress_wrap, .im-create.im-create_classic .im-create--footer, .im-page .im-page--header-inner, .im-page .im-page--top-date-bar, .page_block .im_stickers_bl_wrap, .bd_day_cell, .wall_tt .like_tt_bottom, .like_tt_bottom_page_friend_reply, .im-chat-input .im-chat-input--txt-wrap, .im-page.im-page_classic .im-page--header, .pe_editor, .video_upload_separator_text, .mv_info:before, .im-page--toolsw, .apps_cont_msg, .ui_tab_group_items, .video_upload_tc_wrap .video_tc_upload_btn, .payments_box_instant_pay .payments_box_summary, .bt_comment_form, .video_desktop_live_intro_wrap, .feedback_invite_row .feedback_photo_icon, .audio_layer_container .audio_page_player, .audio_pl_snippet, .audio_pl_snippet .audio_pl_snippet__header, .audio_page_player.audio_page_player_fixed, .audio_pl_edit_box .ape_header, .audio_page_layout .audio_friends_list, .audio_page_layout .audio_friends_list, .audio_pl_edit_box .ape_header, .audio_page_player.audio_page_player_fixed, .audio_layer_container .audio_page_player, .audio_pl_snippet, .audio_pl_edit_box .ape_cover, .audio_pl_edit_box .ape_list_header, .ads_edit_panel_preview .ads_ad_box .ads_ad_box_border, .shorten_list_row, .page_actions_wrap, .ap_layer_wrap .ap_layer__content, .im-page-pinned, .apps_main .apps_install_header, .article, .page_attach_progress_wrap, .im-page.im-page_classic.im-page_group .im-group-online .im-group-online--inner
  {
    background-color: var(--color4);
  }

  .help_table_question_act, .help_table_question__acts .help_table_question_act_ok:hover, .pe_type_chooser_item:hover, .selector_container td.selector .token_inner, .selector_container td.selector .token_prefix, .market_comments_header:hover, .emoji_shop:hover, .pe_editor .pe_sticker_pack_tab.pe_selected, .fc_msgs .audio_row:not(.audio_row_current):hover, .ui_scroll_default_theme>.ui_scroll_bar_container>.ui_scroll_bar_outer>.ui_scroll_bar_inner, .ui_scroll_default_theme.ui_scroll_scrolled>.ui_scroll_bar_container>.ui_scroll_bar_outer>.ui_scroll_bar_inner, .im-audio-message-input .im-audio-message-track, .nim-dialog.nim-dialog_classic:not(.nim-dialog_deleted):hover.nim-dialog_unread-out .nim-dialog--inner-text, .ui_search_new .ui_search_button_search:hover, .ui_search_sugg_list .ui_search_suggestion_selected, .feed_groups_hidden_list_show_btn:hover, .nim-dialog.nim-dialog_classic:not(.nim-dialog_deleted):hover.nim-dialog_unread-out .nim-dialog--inner-text, .nim-dialog.nim-dialog_classic:not(.nim-dialog_deleted):hover.nim-dialog_unread-out.nim-dialog_muted .nim-dialog--inner-text, .medadd_inline_editable:hover, .result_list ul li em, .im-page.im-page_classic.im-page_group .im-group-online.im-group-online-offline .im-group-online--beacon-wrapper, .im-page.im-page_classic.im-page_group .im-group-online .im-group-online--beacon .im-group-online--beacon-wrapper
  {
    background-color: var(--color7);
  }

  .fc_msgs .audio_inline_player .slider .slider_back, .ui_scroll_default_theme.ui_scroll_scrolled .ui_scroll_bar_inner, .ui_scroll_default_theme .ui_scroll_bar_container:hover .ui_scroll_bar_inner, .pe_editor .pe_sticker_pack_tab:hover
  {
    background-color: var(--color8);
  }

  .ui_search_new.ui_search_field_empty .ui_search_button_search
  {
    background-color: var(--color9);
  }

  .im-mess.im-mess_gift, .sortable_blocks> div, .im-page--chat-input._im_chat_input_w, #tickets_msg[style*='249'], .tickets_post_field, .like_tt_bottom_page_friend_reply, .fc_clist_filter_wrap input, #share_cont
  {
    background-color: var(--color4) !important;
  }

  #im_dialogs > li.nim-dialog._im_dialog._im_dialog_62061925.nim-dialog_unread-out.nim-dialog_selected._im_dialog_selected > div.nim-dialog--content > div > div.nim-dialog--unread._im_dialog_unread_ct, #im_dialogs > li.nim-dialog._im_dialog._im_dialog_244215337.nim-dialog_unread-out.nim-dialog_selected._im_dialog_selected > div.nim-dialog--content > div > div.nim-dialog--unread._im_dialog_unread_ct, .nim-dialog.nim-dialog_muted.nim-dialog_selected .nim-dialog--unread, 
.nim-dialog.nim-dialog_selected .nim-dialog--unread, #im_dialogs > li.nim-dialog._im_dialog._im_dialog_12093114.nim-dialog_unread-out.nim-dialog_selected._im_dialog_selected > div.nim-dialog--content > div > div.nim-dialog--unread._im_dialog_unread_ct, .nim-dialog:not(.nim-dialog_deleted).nim-dialog_selected .nim-dialog--unread, .nim-dialog_selected.nim-dialog.nim-dialog_unread-out.nim-dialog_muted:not(.nim-dialog_failed) .nim-dialog--unread, .wcm_send_text_wrap div[contenteditable=true]
  {
    background-color: #fff;
  }

  .datepicker_text, .im-page.im-page_classic.im-page_group .im-group-online
  {
    background-color: var(--color5);
  }

  .exchange_ad_post_club_commment, a.exchange_ad_post_link, a.exchange_ad_post_stats, .wdd_text, .im-mess.im-mess_unread.im-mess_sending .im-mess--marker, .prefix_input_wrap, .im-mess-stack .audio_row.audio_row_current:hover, .im-mess-stack .audio_row.audio_row_playing:hover, .im-mess-stack .audio_row.audio_row_current:hover, .im-page.im-page_classic .im-chat-history-resize, #marketplace .market_content .market_row .market_place_common_friend_badge, .similar_row_wrap .tickets_faq_img img, .similar_row_wrap .tickets_faq_img img:after
  {
    background-color: transparent;
  }

  .nim-dialog:not(.nim-dialog_deleted).nim-dialog_selected .nim-dialog--photo .online.mobile:after
  {
    background-color: #888;
  }

  .im-page a.im-page--back-button:hover:before
  {
    background: -o-linear-gradient(right, var(--color3), var(--color3) 20%);
    background: linear-gradient(270deg, var(--color3), var(--color3) 20%);
  }

  .away_content.away_image
  {
    background-position: -20px 20px;
  }

  .audio-msg-track .audio-msg-track--wave-wrapper .audio-msg-track--wave path
  {
    stroke: var(--color1);
  }

  .im-page--back-btn:hover
  {
    background: linear-gradient(90deg, var(--color3) 50%, var(--color3));
    background-image: url('https://i.imgur.com/Qp5NOug.png');
    background-position: 13px 16px;
    background-repeat: no-repeat;
  }

  .eltt.feature_intro_tt:after, .eltt.feature_intro_tt:before
  {
    background: #212020;
  }

  .im-mess_unread.im-mess_gift
  {
    background-color: var(--color3)!important;
  }

  .error
  {
    background-color: #261e1e;
    border: #463737;
  }

  .audio_inline_player .slider .slider_slide
  {
    background-color: var(--color7)!important;
  }

/*==========================border==============================*/

/*stylecolor*/
  .ui_tab_sel, .ui_tab_sel:hover, .ui_tabs .ui_tab_sel, .ui_tabs .ui_tab_sel:hover, .ui_tabs_box .ui_tab_sel, .ui_tabs_box .ui_tab_sel:hover, .ui_tabs.ui_tabs_sliding:before, .ui_rmenu_item_sel, .ui_rmenu_item_sel:hover, .pg_lnk_sel .pg_in, .im-to-end, .tabbed_box .summary_tabs, .tabbed_box .summary_tab_sel, .audio_friend.audio_friend_selected, .ui_toggler.on:after, .tabbed_box .summary_tab:hover, .tabbed_box .summary_tab_sel:hover, .wk_table td, .wk_table, .audio_progress_wrap, .top_notify_cont .feedback_sticky_rows, a.wk_ext_link:hover
  {
    border-color: var(--color1);
  }

  .ui_tab:hover, .ui_tabs .ui_tab:hover, .pg_lnk:hover, .im_fwd_log_wrap, .im_wall_log_wrap, .wall_module .media_desc .lnk.lnk_mail, .emoji_tab:hover, .post_upload_dropbox_inner, .wk_text blockquote, .docs_choose_dropbox_wrap, .im-dropbox .im-dropbox--inner, .group_api_blockquote, a.wk_ext_link, .help_table_question, .help_table_questions, .tickets_header, .tickets_reply_row, .tickets_thank_you_form, .tickets_suggest, .tu_row, .fc_msgs_out .fc_msgs, .cal_table .day.sel, .cal_table .day.sel.hover, .ui_progress .ui_progress_back, .bd_day_head, .bd_day_cell.holiday.today .bd_day_events, .bd_day_cell.today .bd_day_events, .nim-dialog:not(.nim-dialog_deleted).nim-dialog.nim-dialog_selected:hover, .story_feed_new_item .stories_feed_item_ava, .audio_progress, .im-dropbox--rect
  {
    border-color: var(--color2);
  }

  .page_top, #side_bar .more_div, .counts_module, .leave_redesign, #page_header_cont .back, .ui_tabs, .module_header .header_top, .post_full_like_wrap, .submit_post, .wall_module .reply_box, .wall_module .reply_fakebox_wrap, .profile_info_block, .page_status_editor .editor, .fakeinput, .fakeinput~.placeholder .ph_input, div[contenteditable=true], input.big_text, input.big_text~.placeholder .ph_input, input.dark, input.dark~.placeholder .ph_input, input.search, input.search~.placeholder .ph_input, input.text, input.text~.placeholder .ph_input, textarea, textarea~.placeholder .ph_input, .fakeinput:focus, div[contenteditable=true]:focus, input.big_text:focus, input.dark:focus, input.search:focus,  textarea:focus, .wall_module .replies_list, .ms_items_more, .wall_module .reply~.reply .dld, .wall_module .reply~.reply .reply_wrap, .ui_actions_menu, .ui_tabs.ui_tabs_box, div.wdd, div.wdd.wdd_focused, .wdd_list, .wddi, .wddi_over, .page_block_header, .flat_button.ui_load_more_btn, .pv_comments, #pv_author_block, .box_title_wrap.box_grey, .ts_search_sep, .search_row, .page_block_header, .ui_search, .tt_default, .tt_default_right, .friends_user_row, .ui_actions_menu_sep, .ui_rmenu_sep, #top_profile_menu, .top_profile_sep, .box_controls, .audio_page_player, .mv_wide_column, .mv_actions_panel, .mv_comments_summary, .photos_choose_bottom, .im_stickers_buy_header, .mv_narrow_column, .wall_tt .like_tt_bottom, .group_list_row, .wide_column .topics_module .topic_row, .module.empty .module_body, .bt_header, .bp_post, .media_preview_has_medias, .ba_post, .blst_row, .feed_row+.feed_row_fb_hidden .feedback_row:first-child, .feed_row~.feed_row .feedback_row, .feed_row~.feed_row .feedback_sticky_row, .feedback_sticky_rows+.feed_row .feedback_row, #top_notify_wrap, .top_notify_header, .top_notify_show_all, .feed_row~.feed_row .feedback_row_clickable:not(.feedback_row_touched):hover, .feedback_row_answer, .feedback_row_clickable:not(.feedback_row_touched):hover, .eltt, .top_audio_layer .audio_layer_rows_cont, .audio_layer_bottom, #all_shown, .photos_container .photos_row, #mail_box_editable, .ui_search.ui_search_fixed, .friends_list_bl, .im-page .im-page--dialogs, .im-page .im-page--header-chat, .mention_tt_actions, .im-chat-input, .im-page .im-page--header, .nim-dialog .nim-dialog--content, .nim-dialog:hover+.nim-dialog, .im-page .im-page--dialogs-footer.ui_grey_block, .nim-dialog:hover, .nim-dialog:hover+.nim-dialog, .search_results_sep, .search_auto_results .search_auto_sep .search_auto_sep_inner, .search_auto_results .search_auto_sep, .search_auto_results .post_full_like_wrap, .wl_post_reply_form_forbidden, .wall_module .reply.reply_highlighted, .wall_module .wl_reply_form_fixed .reply_box, .wall_module .wl_reply_form_fixed .reply_fakebox_wrap, .wl_replies_header, .wl_replies_header_progress, .im-mess-stack .im-mess-stack--mess li:last-of-type, #album_name_wrap, .olist_item_wrap, .olist_item_wrap:hover, .olist_botsh .box_controls, .ads_nav .nav_separator, .fc_tab, div.fc_tab_txt, .fc_msgs, .fc_tab_head, #fc_ctabs_cont, div.fc_clist_filter_wrap, .ui_suggester_results_list ul li.active, .ui_suggester_results_list ul li:hover, .ui_suggester_results_list, .gifts_box_rows .post, .pedit_separator, .ui_toggler:after, .ui_grey_block, .tabbed_box .summary_tab_sel:hover, .mv_comments_restricted_msg, .docs_item, .feed_list_name_wrap, .gifts_section_row, #payments_box .payments_about_votes, .page_actions_wrap, .page_actions_inner, .page_actions_separator, .wall_comments_header, .settings_line, .settings_line.unfolded, .settings_block_footer, .blog_jobs_page, .blog_jobs_page .footer_wrap, .blog_about_page .footer_wrap, .wk_poll_tabs, .wk_poll_fixed .wk_poll_tabs, .wk_poll_dmgr, .feed_updates .wall_module .feed_row .post, .wk_extpage_footer_wrap, .photos_edit_selection_header, .photos_container_edit_grid .photos_photo_edit_row_desc_placeholder, .photos_container_edit_grid .photos_photo_edit_row_desc_input:focus, .selector_container, .selector_container table.selector_table, .result_list, .search_sep, #mv_pl_tt .mv_tt_add_playlist, .privacy_dropdown .body, .privacy_dropdown, .privacy_dropdown .item_sel, .privacy_dropdown .item_sel_plus, .privacy_dropdown .header, .idd_popup, .idd_popup .idd_header_wrap, .im-page .im-page--mess-search, .photos_go_to_album, .photos_period_delimiter_fixed, .group_edit_row_sep, .prefix_input_prefix, .prefix_input_border, .group_l_row, .group_l_row:last-child, .group_activity_row_wrap .group_obscene_word, #audio_status_tt .audio_share_cont, .bet_wrap .bnt_media_preview, .info_msg, .fc_tab_notify, .ui_search_fltr, .friends_cur_filters, .pva_period_fixed, .preq_tt, .group_wiki_hider:hover, .medadd_c_linkcon, .owner_photo_additional, .layers_shown .chat_tab_online_icon, .layers_shown .chat_tab_wrap:hover, .feedback_sticky_rows:not(:empty)+.feed_row .feedback_row, .feedback_unread_bar, .feedback_row_wrap.reply_box_open, .video_choosebox_bottom, .online:after, span.fc_contact_photo:after, .emoji_tt_wrap, .ts_contact_photo:after, .ts_contact.active .ts_contact_photo:after, .group_box_row,.wall_module .copy_quote, .gift_tt_show_all, #stats_cont h4, .im_fwd_log_wrap, .im_wall_log_wrap, .docs_choose_rows .docs_item:hover, .page_media_poll_wrap, .feedback_row_wrap.unread .feedback_photo_icon, .feedback_like_row .feedback_photo_icon, .top_notify_cont .feedback_row:hover .feedback_photo_icon, .top_notify_cont .feedback_row:hover .feedback_photo_icon, .feedback_followers_row .feedback_photo_icon, .feedback_publish_row .feedback_photo_icon, .feedback_reply_row .feedback_photo_icon, .ui_search_filters_pane, .nim-dialog.nim-dialog_hovered, .nim-dialog:hover, .nim-dialog.nim-dialog_hovered, .nim-dialog.nim-dialog_hovered + .nim-dialog, .nim-dialog:hover, .nim-dialog:hover + .nim-dialog, .settings_bl_row, input.text:focus, .feed_notifications .more_link, #ads_page_wrap2, #ads_page_wrap1, .ads_main_notice, .exchange_title_head, .exchange_table tr:first-child, .exchange_table tr, .exchange_table tr:last-child, #ads_page_bottom_info, #ads_unions_content h2, #tickets_faq_list, .tickets_faq_row, #ads_unions_content h2, .help_table_questions, .help_table_question_visible, .help_table_question, .apps_i_wrap, .apps_i_panel, .apps_i_policy, .settings_privacy_row, .settings_apps .apps_settings_row_wrap, .box_msg, .msg, .settings_table_row, .settings_block_msg, #settings_votes_history tr td, .dividing_line ul li, .wke_top_fixed .wke_controls, .search_query_wrap .result_list, .group_box_row:last-child, .blog_entry_like_widget, .prefix_input:focus+.prefix_input_border, .tt .tt_text, .nim-dialog:not(.nim-dialog_deleted).nim-dialog.nim-dialog_selected.nim-dialog_hovered, .nim-dialog:not(.nim-dialog_deleted).nim-dialog_hovered+.nim-dialog.nim-dialog_selected, .nim-dialog:not(.nim-dialog_deleted):hover+.nim-dialog.nim-dialog_selected, .nim-dialog:not(.nim-dialog_deleted).nim-dialog_hovered, .nim-dialog:not(.nim-dialog_deleted).nim-dialog_hovered+.nim-dialog, .nim-dialog:not(.nim-dialog_deleted):hover, .nim-dialog:not(.nim-dialog_deleted):hover+.nim-dialog, .flist_item_wrap:hover, .flist_summary_sep .clear, .flist_item_wrap, .flist_sel, .composer_wdd .wdd_list, .page_block #all_shown, .tt_w.top_notify_tt, .sticker_hints_tt, .ads_edit_separator_big, .sticker_hints_arrow, .sticker_hints_arrow:hover, #pv_friends, #pv_friends .name_input input, .nim-dialog:not(.nim-dialog_deleted).nim-dialog.nim-dialog_classic.nim-dialog_unread, .nim-dialog:not(.nim-dialog_deleted).nim-dialog.nim-dialog_hovered, .nim-dialog:not(.nim-dialog_deleted).nim-dialog:hover, .nim-dialog:not(.nim-dialog_deleted).nim-dialog_hovered+.nim-dialog, .nim-dialog:not(.nim-dialog_deleted).nim-dialog_unread.nim-dialog_classic+.nim-dialog, .nim-dialog:not(.nim-dialog_deleted):hover+.nim-dialog, .feedback_friends_row .feedback_photo_icon, .page_attach_progress_wrap, .disabled.selector_container table.selector_table, .vkmenu ol li, .vkmenu ol, .ui_search, .audio_filter.quality_filter.layout-post-2016.append, .pv_author_block, .nim-dialog.nim-dialog_hovered:last-child:not(.nim-dialog_deleted), .nim-dialog.nim-dialog_selected:last-child:not(.nim-dialog_deleted), .nim-dialog.nim-dialog_unread.nim-dialog_classic:last-child:not(.nim-dialog_deleted), .nim-dialog:hover:last-child:not(.nim-dialog_deleted), .login_about_mobile, .dropbox_over .photos_choose_upload_area_drop, .photos_choose_upload_area_enter .photos_choose_upload_area_drop, .dropbox_area, .box_body .im_stickers_store_wrap .ui_tabs, .wk_table th, .wk_hider_box, .wk_hider_box_opened, .module, .nim-dialog:not(.nim-dialog_deleted).nim-dialog.nim-dialog_classic.nim-dialog_unread, .nim-dialog:not(.nim-dialog_deleted).nim-dialog.nim-dialog_hovered, .nim-dialog:not(.nim-dialog_deleted).nim-dialog:hover, .nim-dialog:not(.nim-dialog_deleted).nim-dialog_hovered + .im-page--messages-search, .nim-dialog:not(.nim-dialog_deleted).nim-dialog_hovered + .nim-dialog, .nim-dialog:not(.nim-dialog_deleted).nim-dialog_selected + .im-page--messages-search, .nim-dialog:not(.nim-dialog_deleted).nim-dialog_selected + .nim-dialog, .nim-dialog:not(.nim-dialog_deleted).nim-dialog_unread.nim-dialog_classic + .im-page--messages-search, .nim-dialog:not(.nim-dialog_deleted).nim-dialog_unread.nim-dialog_classic + .nim-dialog, .nim-dialog:not(.nim-dialog_deleted):hover + .im-page--messages-search, .nim-dialog:not(.nim-dialog_deleted):hover + .nim-dialog, #wpost_post, .tickets_thank_you_form__inner, .tickets_thank_you_form__title, .datepicker_control, .bv_wrap .bt_pages_wrap, .tickets_post_field, .cal_table, .validation_readonly_wrap, .validation_row input.validation_readonly, .upload_progress_wrap, .im-page .im-page--header-inner, #ads_left.ads_left_empty+.left_menu_nav_wrap, .im-page .im-page--history-new-bar_days>span:before, .im-page .im-page--top-date-bar.im-page--date-bar-transition.im-page--date-bar-transition-inverse, .group_info_row:before, .group_friends_image, .ui_search_new.ui_search_field_empty .ui_search_button_search, .ui_search_new .ui_search_input_inner, .im-chat-input .im-chat-input--txt-wrap, .ui_tab_group_items, .video_upload_progress, .audio_pl_snippet, .audio_page_layout .has_friends_block .audio_page__rows_wrap, .audio_pl_edit_box .ape_header, .audio_pl_edit_box .ape_add_audios_btn, .audio_pl_edit_box .ape_add_pl_audios_btn, .audio_pl_snippet, .audio_pl_edit_box .ape_cover, .audio_pl_snippet .audio_pl_snippet__cover, .audio_pl_attach_preview, .ads_edit_panel_preview .ads_ad_box .ads_ad_box_border, .vk_msg_info_icon:before, .feedback_photo_icon, .module_header.header_separated, .im-page-pinned
  {
    border-color: var(--color3);
  }

  .article a
  {
    border-bottom-color: var(--color2);
  }

  .article a:hover
  {
    border-bottom-color: var(--color1);
  }

  .post_friend_liked, .feedback_invite_row .feedback_photo_icon
  {
    border-color: var(--color4);
  }

  .im-page_classic .im-page--chat-header
  {
    border-color: var(--color5);
  }

  .im-page .im-page--top-date-bar, .im-page .im-page--top-date-bar, .bd_day_cell.left, .bd_day_cell, .ui_search_sugg_list, .ui_search_new .ui_search_button_search, .im-chat-input .eltt.page_video_autoplay_tt, .im-page .im-page--top-date-bar_visible .im-page--history-new-bar_days.im-page--date-bar-transition>span, .top_notify_cont .top_notify_header
  {
    border-color: var(--color7);
  }

  .ui_search_new.ui_search_field_empty .ui_search_button_search
  {
    border-color: var(--color9);
  }

  .slider_hint:after, .tt_default.verified_tt.tt_down:after, .tt_default.tt_down:after, .nim-dialog.nim-dialog.nim-dialog_selected:hover, .nim-dialog:hover+.nim-dialog.nim-dialog_selected, .ms_items_more_wrap.to_up .ms_items_more:after, .ui_toggler.on, .mention_tt.mention_has_actions.tt_default.tt_down:before, .im-page.im-page_group .im-page--header, .tt_default_right.tt_down:after, .eltt.eltt_top:after, .im-page.im-page_classic .im-page--header-chat, .im-page.im-page_classic .im-page--header, .emoji_tt_wrap.emoji_shop_over.tt_down:after, .ui_actions_menu_top .ui_actions_menu:after
  {
    border-top-color: var(--color4);
  }

  .slider_hint:after
  {
    border-top-color: var(--color1);
  }

  .ms_items_more_wrap.to_up .ms_items_more:before, .emoji_tt_wrap.emoji_no_tabs.tt_down:after, .emoji_tt_wrap.tt_down:before, .mention_tt.mention_has_actions.tt_default.tt_down:after, .emoji_tt_wrap.tt_down:after, .ui_search_filters_pane, .wke_bottom_fixed .box_controls, .tt_default.tt_down:before, .tt_default.verified_tt.tt_down:before, .tt_default_right.tt_down:before, .eltt.eltt_top:before, .index_page .index_footer_wrap, .index_fbsign, .nim-dialog:not(.nim-dialog_deleted).nim-dialog_selected+.nim-dialog, .im_stickers_my_row~.im_stickers_my_row, .market_item_footer_wrap, .pe_editor .pe_bottom_actions, .wall_note_type, #ads_left:empty+.left_menu_nav_wrap, .ui_actions_menu_top .ui_actions_menu:before, .apps_footer, .login_page #footer_wrap, .join_finish_page #footer_wrap, .tickets_thank_you_form, #stats_cont h4, .stats_head, .im-audio-message-input, .payments_offer_row, .im-create .im-creation--item.im-creation--item_hovered, .im-create .im-creation--item:hover, .feed_row ~ .feed_row .feedback_row_wrap.reply_box_open, .feed_row~.feed_row .feedback_row, .feed_row~.feed_row .feedback_sticky_row, .feed_row~.feed_row_fb_hidden .feed_row:first-child .feedback_row, .feedback_sticky_rows:not(:empty)+.feed_row .feedback_row, .feedback_sticky_rows:not(:empty)+.feed_row .feedback_sticky_row, .fave_link_item_inner, .wall_tt.tt_default.tt_down:not(.post_source_tt):not(.fw_reply_tt):after, .wall_module.wl_post .reply .reply_wrap, #apps_catalog .apps_catalog_row, .bt_sb_block, .audio_layer_container .audio_page__footer, .eltt.eltt_top.eltt_arrow_size_normal .eltt_arrow, .audio_layer_container .audio_page__footer, .eltt.eltt_top.eltt_arrow_size_normal .eltt_arrow_back, .stats_time_info, .eltt.eltt_top.eltt_arrow_size_normal>.eltt_arrow_back .eltt_arrow, .nim-dialog:not(.nim-dialog_deleted).nim-dialog.nim-dialog_classic.nim-dialog_unread, .nim-dialog:not(.nim-dialog_deleted).nim-dialog.nim-dialog_hovered, .nim-dialog:not(.nim-dialog_deleted).nim-dialog:hover, .nim-dialog:not(.nim-dialog_deleted).nim-dialog_hovered+.im-search-results-head, .nim-dialog:not(.nim-dialog_deleted).nim-dialog_hovered+.nim-dialog, .nim-dialog:not(.nim-dialog_deleted).nim-dialog_selected+.im-search-results-head, .nim-dialog:not(.nim-dialog_deleted).nim-dialog_selected+.nim-dialog, .nim-dialog:not(.nim-dialog_deleted).nim-dialog_unread.nim-dialog_classic+.im-search-results-head, .nim-dialog:not(.nim-dialog_deleted).nim-dialog_unread.nim-dialog_classic+.nim-dialog, .nim-dialog:not(.nim-dialog_deleted):hover+.im-search-results-head, .nim-dialog:not(.nim-dialog_deleted):hover+.nim-dialog
  {
    border-top-color: var(--color3);
  }

  .sticker_extra_tt.tt_text_only .toup:after, .tt_default.tt_left:after
  {
    border-right-color: var(--color4);
  }

  .sticker_extra_tt.tt_text_only .toup:before, .im-page.im-page_classic .im-page--chat-input, .im-page.im-page_classic .im-page--header-chat, .im-page.im-page_classic .im-page--header, .tt_default.tt_left:before, .mv_info_wide_column, .vk_settings_block.vk_settings_block_left
  {
    border-right-color: var(--color3);
  }

  .friends_actions_menu .ui_actions_menu:after, #top_profile_menu:after, .ui_actions_menu:after, .feedback_row_answer:after, #top_notify_wrap:after, .top_notify_prefs .ui_actions_menu:after, .tabbed_box .summary_tab_sel:hover,  .ms_items_more_wrap.to_down .ms_items_more:after, .ui_search_fltr:before, .ui_search_fltr:after, .preq_tt:before, .preq_tt:after, .feedback_sticky_actions .feedback_sticky_menu .ui_actions_menu:before, #top_notify_wrap:before, .emoji_tt_wrap.tt_up:before, .emoji_tt_wrap.tt_up:after, .feedback_row_answer:before, .feedback_row_answer:before, .ui_actions_menu:before, .tt_default_right.tt_up:before, .tt_default_right.tt_up:after, .feed_lists_icon .ui_actions_menu:before, .ms_items_more_wrap.to_down .ms_items_more:before, .mention_tt.tt_up:before, .friends_actions_menu .ui_actions_menu:before, .stats_head,#top_profile_menu:before, .feedback_row_wrap.reply_box_open .reply_box:before, .feedback_row_wrap.reply_box_open .reply_box:after, .groups_actions_menu .ui_actions_menu:before, .wke_controls, .tt_default.tt_up:before, .docs_choose_rows .docs_item, .message_page_title, .tt_w.top_notify_tt.tt_up:before, .tt_default.verified_tt.tt_up:before, .im-page .im-page--header-chat, .im-page .im-page--header, .im-page .im-page--search-header, .blog_arhive_item, .eltt.eltt_bottom:before, .top_notify_cont .feedback_row_menu .ui_actions_menu:before, .ui_actions_menu_dummy_wrap.feedback_row_menu .ui_actions_menu:before, .market_comments_summary, .market_item_owner, .bd_row, .settings_blb_row, .im-member-item, .mv_actions_block, .help_tile_alert, .pe_editor .pe_tabs, .audio_filter.quality_filter.layout-post-2016.prepend, .summary_tabs, .apps_options_bar, .piechart_table tr td, h2.payments_getvotes_title, .group_l_row.sort_taken, .group_l_row.sort_taken:last-child, .group_l_rows .sort_helper, .wide_column .page_top, .page_friend_reply, .group_box_list .sort_helper, .market_item_footer_info, .eltt.eltt_bottom.top_audio_layer:after, .im-page--chat-header-in, #marketplace .market_content .market_row_line, .im-page--toolsw, .new_public_header, .new_public_type, .payments_box_instant_pay .payments_box_summary, #apps_catalog .apps_catalog_row, .bt_report_row, .audio_layer_container .audio_page_player, #audio_layer_tt>.eltt_arrow_back .eltt_arrow, .audio_pl_snippet .audio_pl_snippet__header, .eltt.eltt_top.eltt_arrow_size_normal .eltt_arrow_back, .eltt.eltt_bottom.eltt_arrow_size_normal .eltt_arrow, .audio_feed_post, .eltt.eltt_bottom.eltt_arrow_size_normal .eltt_arrow_back, .audio_layer_container .audio_page_player, #audio_layer_tt>.eltt_arrow_back .eltt_arrow, .audio_pl_snippet .audio_pl_snippet__header, .audio_pl_snippet .audio_pl_snippet__header, .mv_live_gifts_block, .shorten_list_row, .shortener_stats_header, .apps_main .apps_install_header, .apps_install_header, a.group_app_button_multi
  {
    border-bottom-color: var(--color3);
  }

  .mv_subscribe_block .mv_subscribe_btn_count:after
  {
    border-left-color: var(--color7);
  }

  ._audio_layout.audio_layout._audio_layer
  {
    border-top: 1px solid var(--color3);
  }

  .tickets_side_tt.extra_field:before, .tickets_side_tt.text:before, .tickets_side_tt.title:before, .im-page.im-page_classic .im-page--chat-input, .im-page.im-page_classic .im-page--header-chat, .im-page.im-page_classic .im-page--header, .fc_tab_pointer:before, .mv_info_narrow_column, .tt_default.tt_right:before, .fc_tab_pointer:after, .wall_module .published_by_quote, .wall_module .published_sec_quote, .im-fwd, .mv_subscribe_block .mv_subscribe_live_btn, .im-mess .im-mess--post, .mv_live_gifts_supercomment
  {
    border-left-color: var(--color3);
  }

  .tickets_side_tt.extra_field:after, .tickets_side_tt.text:after, .tickets_side_tt.title:after, .fc_tab_pointer.fc_tab_pointer_peer:after, .tt_default.tt_right:after
  {
    border-left-color: var(--color4);
  }

  #audio_layer_tt:after, .feedback_sticky_actions .feedback_sticky_menu .ui_actions_menu:after, .feedback_row_answer:after, .ui_actions_menu:after, .feed_lists_icon .ui_actions_menu:after, .ms_items_more_wrap.to_down .ms_items_more:after, .mention_tt.tt_up:after, .friends_actions_menu .ui_actions_menu:after, #top_profile_menu:after, .eltt.eltt_up:after, .groups_actions_menu .ui_actions_menu:after, .tt_default.tt_up:after, .eltt.eltt_bottom:after, .im-page.im-page_classic .im-page--chat-input, .tt_w.top_notify_tt.tt_up:after, .tt_default.verified_tt.tt_up:after, .top_notify_cont .feedback_row_menu .ui_actions_menu:after, .ui_actions_menu_dummy_wrap.feedback_row_menu .ui_actions_menu:after
  {
    border-bottom-color: var(--color4);
  }

  .im-mess-stack .im-mess-stack--mess li:last-of-type
  {
    border-bottom-color: var(--color4) !important;
  }

  .im-page.im-page_classic .im-page--chat-input
  {
    border-color: var(--color5);
  }

  .im-chat-input--textarea .im-chat-input--text, .vkmenu ol, .wk_table
  {
    border-color: var(--color3) !important;
  }

  .top_notify_count
  {
    border: none;
  }

  .im-page.im-page_classic .im-page--chat-body-wrap-inner
  {
    border-color: transparent;
  }

  .im-page--header.ui_search._im_dialogs_search
  {
    border-top-color: var(--color5) !important;
    border-left-color: var(--color5) !important;
    border-right-color: var(--color5) !important;
  }

  .nim-peer.nim-peer_online .nim-peer--online, .chat_tab_online_icon, .chat_tab_wrap:hover .chat_tab_online_icon, .ts_contact_photo:after, span.fc_contact_photo:after, .online:after, .wddi_over .wddi_thumb .wdd_mark, .wdd_mark, .layers_shown .chat_tab_online_icon, .friends_user_row .online:after, .group_u_photo.online:after, .chat_tab_imgcont.online:after
  {
    border-color: var(--color7) !important;
    border-width: 2px;
  }

/*mobile_online*/
  .chat_tab_imgcont.online.mobile:after, span.fc_contact_photo.online.mobile:after, .online.mobile:after, .chat_tab_wrap:hover .chat_tab_imgcont.online.mobile:after, .friends_user_row .online.mobile:after, .ts_contact_photo.online.mobile:after, .ts_contact.active .ts_contact_photo.online.mobile:after, a.fc_contact_over span.fc_contact_photo.online.mobile:after
  {
    border-color: #292929 !important;
    background-color: #444;
  }

  .nim-dialog.nim-dialog_hovered .nim-dialog--photo .online.mobile:after, .nim-dialog:hover .nim-dialog--photo .online.mobile:after, .nim-dialog.nim-dialog_muted.nim-dialog_selected .nim-dialog--photo .online.mobile:after, .nim-dialog.nim-dialog_selected .nim-dialog--photo .online.mobile:after, .nim-dialog:not(.nim-dialog_deleted).nim-dialog_muted.nim-dialog_selected .nim-dialog--photo .online.mobile:after, .nim-dialog:not(.nim-dialog_deleted).nim-dialog_selected .nim-dialog--photo .online.mobile:after, .nim-dialog:not(.nim-dialog_deleted).nim-dialog_hovered .nim-dialog--photo .online.mobile:after, .nim-dialog:not(.nim-dialog_deleted):hover .nim-dialog--photo .online.mobile:after, .im-mess-stack .audio_inline_player .slider .slider_slide, .fans_fan_ph.online.mobile:after
  {
    background-color: #444;
  }

  ._im_dialog_selected .chat_tab_imgcont.online.mobile:after,._im_dialog_selected span.fc_contact_photo.online.mobile:after,._im_dialog_selected .online.mobile:after
  {
    border-color: var(--color1) !important;
  }

  .audio_page_player._audio_page_player._audio_row.clear_fix.audio_page_player_fixed.audio_page_player_fixed_shown
  {
    border-top: 1px solid var(--color7);
    border-bottom: 1px solid var(--color7);
  }

  .audio_pl_edit_box .ape_pl_item:hover
  {
    border-top-color: var(--color7);
    border-bottom-color: var(--color7);
  }

/*=======================font===========================*/

/*maincolor*/
  a, .page_counter .count, .page_counter:hover .label, .post_author .author, .wall_module .author, .wall_module .copy_author, .page_doc_row .page_doc_title, .wall_module .post_like_count, .wall_module .post_share_count, .wall_module .my_like .like_count, .wall_module .my_share .share_count, .ui_rmenu_item, .ts_contact_name, .ui_actions_menu_item .wddi_text, .wddi_text, .pv_like, .pv_liked .pv_like_count, .friends_find_user_name, .friends_import_header, .top_profile_mrow, .listing, .audio_owner_info_name a, .wall_module .media_desc .a, .wide_column .topics_module .topic_title, .bp_author, .pg_lnk_sel .pg_in, .blst_title, .blst_mem, .fw_reply_author, .wall_module a.page_media_link_title, .wall_module span.page_media_link_title, a.docs_item_name, .mail_box_label_peer, div.top_result_baloon a, .olist.audio_album .olist_item_performer, .olist_item_name, #notifiers_wrap a, .notifier_baloon_msg span.group_link, .notifier_baloon_msg span.mem_link, .chat_onl, .fc_contact_name, .im-page-btn, a b, b a, .app_link, .apps_notification_header a, .header_side_link, .header_side_link a, .ads_ad_title_box.apps_only, .ads_ad_title_box.groups_only, .page_media_poll_title, .payments_getvotes_method_title, .page_actions_item, .ui_ownblock_label, .lang_box_row_label, .blog_product_title, .blog_snapster_title, .blog_about_company_stat_number, .blog_about_company_office_city, .blog_about_link_title, .summary_tab3, .page_group_name, .feed_article_title, .privacy_dropdown .item, .privacy_dropdown .item_sel, .privacy_dropdown .item_sel_plus, .idd_popup .idd_item, .wall_module .media_desc .lnk .lnk_mail_title, .im-page .im-page--mess-search, .group_edit_labeled .idd_wrap .idd_selected_value, a.group_l_title, a.group_u_title, .friends_cur_filters .token, .feedback_header .author, .feedback_header .group_link, .feedback_header .mem_link, .feedback_sticky_text .group_link, .feedback_sticky_text .mem_link, .current_audio, .top_nav_btn b, .group_box_name .group_link, .group_box_name .mem_link, .im-mess .im-mess--btn, .nim-dialog.nim-dialog_muted.nim-dialog_selected .nim-dialog--unread, 
.nim-dialog.nim-dialog_selected .nim-dialog--unread, .post_upload_dropbox, .page_actions_cont.narrow .page_actions_header_inner, .top_nav_btn a b, .exchange_table_hint, .exchange_task_actions a, .exchange_task_label a, .help_tile_faqs__row_a, .help_table_question_visible .help_table_question__q, .apps_i_group .apps_i_group_name, .page_actions_item.page_actions_item_lock, .flist_item_name, .notify_tt_text .group_link, .notify_tt_text .mem_link, .blog_more_but, .blog_arhive_title a, .tickets_author, .tickets_author .mem_link, .tu_row_title__a, .help_tile_faqs__row_a, .help_table_question .help_table_question__q, .ui_actions_menu_item, .vkmenu ol li a:hover, .audio_filter.download_controls.layout-post-2016 > div.label, #side_bar ol li .left_row, .ui_actions_menu_item.ui_actions_menu_item_lock .ui_actions_menu_item_lock_text, .market_item_owner_name, .market_album_name_link, a.settings_blb_title, .mv_actions_block .download_control > .download_label, .post_like:hover, .post_share:hover, .my_like .market_like_count, .apps_i_description_show_more, .payments_offer_row_title, .im-mess-stack .im-mess-stack--content .im-mess-stack--pname>a, .im_cal_clear_lnk, .feed_filters_show_types_btn, a.group_app_button, .box_controls.group_age_disclaimer_box .flat_button.group_age_disclaimer_close, .wcommunity_name .wcommunity_name_link, .wcommunity_post_date, .post_author .author, .wall_module .author, .page_group_name, .wall_module .copy_author, #marketplace .market_content .link, .im-fwd .im-fwd--title, a.group_blb_user_name, .group_blb_user_row, .feed_blog_reminder_large .feed_blog_reminder_title, .feed_blog_reminder_link, .audio_pl_edit_box .ape_cover_title, .audio_pl_edit_box .ape_audio_item_wrap .ape_attach, ._audio_section__search .audio_row.audio_has_lyrics .audio_row__title_inner, .ap_layer__content .audio_row.audio_has_lyrics .audio_row__title_inner, .audio_page__audio_rows .audio_row.audio_has_lyrics .audio_row__title_inner, .audio_section_global_search__audios_block .audio_row.audio_has_lyrics .audio_row__title_inner, .audio_row__more_actions .audio_row__more_action, .audio_row .audio_row__performer, .im-page .nim-conversation-search-row .nim-dialog--name .nim-dialog--name-w, .post_dislike:hover, .im-page .im-page--clear-recent, .im-page-pinned--name, .im-page-pinned--media, .im-dropbox--msg, .blog_entry_text_wrap .wk_text a b, .blog_entry_text a b, .article a
  {
    color: var(--color1);
  }

  .post_video_title, .wall_module .my_like .post_like_count, .wall_module .my_share .post_share_count
  {
    color: var(--color1)!important;
  }

/*maincolor2*/
  .post_like, .post_share, .post_full_like_wrap .reply_link, .profile_info_header_wrap a, .pv_like_count, .wall_copy_more, .wall_post_more, .wall_reply_more, .audio_row.lyrics .audio_title_inner, .wall_module .like_count, .mv_more .idd_arrow, .mv_more.idd_wrap .idd_arrow, .topics_module .topic_inner_link, .topics_module .topic_inner_link, .nim-dialog .nim-dialog--preview-attach, .im-page .im-page--stars, .pv_desc_more, .exchange_table th, .help_tile__all, .im-right-menu.ui_rmenu .im-right-menu--count, .tickets_header_title, div.tu_mem, .help_tile_faqs__row_a, .help_tile__all, .tickets_suggests_all_results, .audio_filter, .pe_undo_wrap #pe_undo, .market_like, .market_share, .market_like_count, .app_actions_menu_wrap, .nim-dialog:not(.nim-dialog_deleted).nim-dialog_hovered .nim-dialog--preview.nim-dialog--preview-attach, .nim-dialog:not(.nim-dialog_deleted).nim-dialog_selected .nim-dialog--preview.nim-dialog--preview-attach, .nim-dialog:not(.nim-dialog_deleted).nim-dialog_unread.nim-dialog_classic .nim-dialog--preview.nim-dialog--preview-attach, .nim-dialog:not(.nim-dialog_deleted):hover .nim-dialog--preview.nim-dialog--preview-attach, ._reply_lnk, .vk2017_snippet_full_text_btn, .im-page--back-btn:hover, .post_reply, .post_reply:hover, .wl_replies_header.wl_replies_header_clickable, .bt_report_title_link, .audio_pl_snippet .audio_pl_snippet__more_btn, .story_feed_new_item .stories_feed_item_name, .vk_msg_info_icon:before, .im-right-menu .im-right-menu--count, .post_dislike, a.group_app_button
  {
    color: var(--color2);
  }

  .fc_msgs_out .fc_msgs, .fc_msg_media .audio_row .audio_info_divider, .fc_msg_media .audio_row .audio_title, .fc_msg_media .audio_row .audio_duration, .feed_new_posts>b
  {
    color: var(--color3);
  }

  .mott_apps a
  {
    color: #4F657E;
  }

  .search_media_rows .header_side_link a, .search_results .header_side_link a, .wall_signed_by, .mv_more .idd_arrow, .mv_more.idd_wrap .idd_arrow
  {
    color: #68819C;
  }

  .wl_post_actions_wrap .ui_actions_menu_more
  {
    color: #85a0bb;
  }

  a.friends_possible_link, .pedit_add_row, div#delete, .wl_more_action.idd_wrap .idd_arrow, .ui_actions_menu_sublist .ui_actions_menu_item.checked, .ui_actions_menu_item.feed_new_list, .ui_search_custom_link.idd_wrap .idd_arrow
  {
    color: #7d9ab7;
  }

  .audio-extended .audio_row.download .audio_info.filesize .download_info
  {
    color: #504f49;
  }

  #im_dialogs > div.ui_scroll_overflow > div.ui_scroll_outer > div > div.ui_scroll_content > li.nim-dialog._im_dialog.nim-dialog_selected._im_dialog_selected .nim-dialog--preview
  {
    color: #fff;
  }

  .reply[style*='0);'],
.reply[style*='1);'],
.reply[style*='2);'],
.reply[style*='3);'],
.reply[style*='4);'],
.reply[style*='5);'],
.reply[style*='6);'],
.reply[style*='7);'],
.reply[style*='8);'],
.reply[style*='9);'],
._wall_post_cont[style*='0);'],
._wall_post_cont[style*='1);'],
._wall_post_cont[style*='2);'],
._wall_post_cont[style*='3);'],
._wall_post_cont[style*='4);'],
._wall_post_cont[style*='5);'],
._wall_post_cont[style*='6);'],
._wall_post_cont[style*='7);'],
._wall_post_cont[style*='8);'],
._wall_post_cont[style*='9);'],
._wall_post_cont[style$='0);'],
._wall_post_cont[style$='1);'],
._wall_post_cont[style$='2);'],
._wall_post_cont[style$='3);'],
._wall_post_cont[style$='4);'],
._wall_post_cont[style$='5);'],
._wall_post_cont[style$='6);'],
._wall_post_cont[style$='7);'],
._wall_post_cont[style$='8);'],
._wall_post_cont[style$='9);'],
.reply[style$='0);'],
.reply[style$='1);'],
.reply[style$='2);'],
.reply[style$='3);'],
.reply[style$='4);'],
.reply[style$='5);'],
.reply[style$='6);'],
.reply[style$='7);'],
.reply[style$='8);'],
.reply[style$='9);']
  {
    background-color: var(--color3) !important;
  }

  .box_no_buttons[style*='0);'],
.box_no_buttons[style*='1);'],
.box_no_buttons[style*='2);'],
.box_no_buttons[style*='3);'],
.box_no_buttons[style*='4);'],
.box_no_buttons[style*='5);'],
.box_no_buttons[style*='6);'],
.box_no_buttons[style*='7);'],
.box_no_buttons[style*='8);'],
.box_no_buttons[style*='9);'],
.box_no_buttons[style$='1);'],
.box_no_buttons[style$='2);'],
.box_no_buttons[style$='3);'],
.box_no_buttons[style$='4);'],
.box_no_buttons[style$='5);'],
.box_no_buttons[style$='6);'],
.box_no_buttons[style$='7);'],
.box_no_buttons[style$='8);'],
.box_no_buttons[style$='9);'],
._post[style$='1);'],
._post[style$='2);'],
._post[style$='3);'],
._post[style$='4);'],
._post[style$='5);'],
._post[style$='6);'],
._post[style$='7);'],
._post[style$='8);'],
._post[style$='9);'],
._post[style$='0);']
  {
    background-color: var(--color4) !important;
  }

  .reply_text>div[style*='0);'],
.reply_text>div[style*='1);'],
.reply_text>div[style*='2);'],
.reply_text>div[style*='3);'],
.reply_text>div[style*='4);'],
.reply_text>div[style*='5);'],
.reply_text>div[style*='6);'],
.reply_text>div[style*='7);'],
.reply_text>div[style*='8);'],
.reply_text>div[style*='9);'],
.feed_row[style*='1);'],
.feed_row[style*='2);'],
.feed_row[style*='3);'],
.feed_row[style*='4);'],
.feed_row[style*='5);'],
.feed_row[style*='6);'],
.feed_row[style*='7);'],
.feed_row[style*='8);'],
.feed_row[style*='9);'],
.feed_row[style*='0);']
  {
    background-color: var(--color3) !important;
  }

  #wpe_text[style*='0);'],
#wpe_text[style*='2);'],
#wpe_text[style*='3);'],
#wpe_text[style*='4);'],
#wpe_text[style*='5);'],
#wpe_text[style*='6);'],
#wpe_text[style*='7);'],
#wpe_text[style*='8);'],
#wpe_text[style*='9);'],
#wpe_text[style*='1);']
  {
    background-color: var(--color2) !important;
    color: #fff !important;
  }

  img[src="/images/deactivated_100.png"],a[style*="/images/deactivated_50.png"],img[src="/images/deactivated_50.png"],img[src="/images/deactivated_sad_200.gif"],img[src="/images/deactivated_200.gif"],[src="/images/deactivated_tir_200.gif"],img[src="/images/deactivated_hid_200.gif"],img[src="/images/deactivated_cen_200.gif"]
  {
    -webkit-filter: brightness(0.454)contrast(3.2)saturate(0);
    filter: brightness(0.454)contrast(3.2)saturate(0);
  }

  img[src="/images/camera_100.png"], img[src="/images/camera_200.png"], img[src="/images/community_100.png"],img[src="/images/community_50.png"], .no_avatar, img[src="/images/camera_50.png"], img[src="/images/lnkouter.png"], .ow_ava.ow_ava_small[style*="camera_50.png"], .page_avatar_img[src*="soviet_200"], img[src*="soviet_50"], img[src*="soviet_100"], div[style*="camera_50"], img[src*='multichat_flat']
  {
    -webkit-filter: saturate(0)invert(1);
    filter: saturate(0)invert(1);
  }

  .chat_tab_close
  {
    z-index: 999;
  }

/*maincolor2*/
  .audio_play, .ui_tab_plain, .emoji_smile_icon, #stl_text, .box_x_button.box_x_tabs, .box_title_wrap.box_grey .box_x_button .post_actions.post_actions_progress:before, .box_body .ui_box_search, .page_verified, .ui_search_reset, .friends_find_user_add, .friends_search_filters, .friends_search_import, .ui_calendar_icon, .ui_rmenu_item_arrow, .wall_module .like_icon, .audio_page_player .audio_control_btn .icon, .audio_upload_btn, .box_x_button, #mv_comments_header .pr, .mv_add_button .mv_add_icon, .mv_share_button .mv_share_icon, .web_cam_photo_icon, .photos_choose_upload_area_label, .flat_button.ui_load_more_btn .pr, .hide_icon, .videocat_channel_subscribe .videocat_subscribe_btn .videocat_icon, .wall_module .media_desc b, .wall_module .media_preview .note b, .wall_module .media_preview .poll b, .wall_module .media_preview .share b , .wall_module .reply_to_title .reply_to_cancel, .bp_action, .checkbox:before, .top_notify_cont .pr, .video_item .media_check_btn, .docs_choose_upload_area_label, .page_docs_preview .page_media_x_wrap .page_media_xm, .im-mess .im-mess--check, .im-mess .im-mess--fav, .wall_signed_by, .im-dialog-select .im-dialog-select--btn, .im-page .im-page--stars i, .nim-dialog .nim-dialog--close, .im-page .im-page--dialogs-settings, .progress, .progress_inv, .progress_inv_img, .im-page .im-page--history.im-page--history_loading:before, .im-page .im-page--header-more .ui_actions_menu_icons, .wl_post_share .wl_action_icon, .wr_header .pr, .sort_not_rev_icon, .sort_rev_icon, .audio_album_recom_btn, .audio_album_edit_btn .audio_album_edit_btn_icon, .profile_gift_send_btn .send_thumb, .pv_comments_header .pr, .fc_tab_attach .ms_item_more, .fc_contact_mobile .fc_contact_status, .fc_contact_online .fc_contact_status, .fc_contact_over:hover .fc_contact_status, .fc_msg_att_icon_doc, .fc_msg_att_icon_mail, .fc_msg_att_icon_wall, .pv_place_label, .hint_icon:after, .ui_multiselect_cnt .token .token_del, .ui_search_filters_pane .token .token_del, .mv_edit_button .mv_edit_icon, .app_rate, .docs_item_icon, .docs_action_icon, .ads_ad_app_rating .ads_ad_app_rate, .wk_subscribe_icon, .ui_actions_menu_item.feed_new_list, .page_media_poll .page_poll_row.page_poll_voted:before, .wdd_add_plus, .payments_getvotes_method_img, .blog_job_icon, .photos_container_edit_grid .photos_photo_edit_row_selector .photos_photo_edit_row_selector_icon, .selector_container td.selector .token span.x, .selector_container td.selector .token span.x_hover, #mv_pl_tt .mv_tt_add_playlist .mv_tt_plus_icon, .ui_progress .ui_progress_bar, .group_l_row .group_l_delete, .group_l_row .group_l_edit, .group_l_row .group_l_progress, .page_docs_preview .page_media_x_wrap .page_media_x, .info_msg, .friends_cur_filters .token .del_icon, .blst_closed, .blst_fixed, .feedback_sticky_hide, .feedback_sticky_hide, .current_audio_icon, .box_title_wrap.box_grey .box_x_button, .pv_like_icon, .pv_liked .pv_like_icon, .wall_module .my_like .like_icon, .wall_module .reply:hover .like_wrap.my_like .like_icon, .group_box_extra .info_icon_email, .group_box_extra .info_icon_phone, .gift_tt_show_all:after, .gift_tt_hide:after, .fc_tab_attach .media_selector .ms_item_more, .bp_post .bp_action:hover, .market_module .page_market_more_btn:after, .gift_delete, .gift_send_btn, .ui_search_filters_reset, .feedback_grouped_row_wrap .post_actions, .docs_choose_dropbox, .media_preview .progress_x, .page_media_place_label_inline:before, .audio_page_player .audio_page_player_play .icon, .audio_page_player .audio_page_player_next .icon, .audio_page_player .audio_page_player_prev .icon, .audio_page_player .audio_page_player_btns .icon, .exchange_ad_post_club_commment, a.exchange_ad_post_link, a.exchange_ad_post_stats, .help_tile__all:after, .apps_access_icon, .apps_cat_header_icon, .friends_cur_filters .token:hover .del_icon, .pedit_add_row, .ui_tab_search_wrap .ui_search_reset:hover, .ui_search_loading .ui_search_reset, .feedback_sticky_gift_btn, .feedback_sticky_menu_icon, .feedback_sticky_gift_btn:hover, .feedback_sticky_gift_btn:hover, .settings_apps .apps_settings_action_edit, .settings_apps .apps_settings_action_remove, .settings_history_thumb, .wke_b, .wdd_add:hover .wdd_add_plus, .ui_calendar_icon:hover, .search_media_rows .header_side_link a, .search_results .header_side_link a, .blog_link_icon, .ui_header_ext_search, .search_filter_open .arrow, .search_filter_shut .arrow, .audio_hq_label_show .audio_row.hq .audio_hq_label, .audio_search_rows .audio_row.hq .audio_hq_label, a.groups_messages_block::before, .mott_app, .page_docs_preview .page_media_x_wrap:hover .page_media_x, .post:hover .gift_delete:hover, .audio_upload_btn:hover, .nim-dialog .nim-dialog--markre, .im-page.im-page_group .im-page--gim-mute, .audio_menu_btn.audio_upload_btn, .audio_menu_btn.audio_edit_feed_btn, .friends_sort_common, .friends_sort_date, .pv_comments_list .ms_item_more, .pv_reply_form .ms_item_more, .tickets_tt_list, .tickets_tt_list_abuse, a.friends_possible_link, .im-page .im-page--header-icon.im-page--header-icon_search:before, .vkmusic-btn-download-link-new, .im-page.im-page_classic .im-page--back:before, .im-right-menu.ui_rmenu .im-right-menu--close:before, .ads_edit_link_type_item .ads_edit_link_type_item_image, .emoji_sprite, .sticker_hints_arrow, #pv_del_reply_to, #pv_tags .delete, .ui_search_reset:hover, .nim-dialog .nim-dialog--star, .feed_asc_x_button, .feed_asc_x_button:hover, .tu_info.tu_info_ok:before, .tu_info.tu_info_waiting:before, .im-page .im-page--header-icon:before, .audio_delete_current_btn, .ui_actions_menu_item.im-action:before, .ui_actions_menu_item.im-action:hover:before, .audio_delete_current_btn:hover, .audio_row.download:hover .btn_download:hover, .audio_row.download .btn_download, .audio_row.download .download_info, .pedit_privacy_control .privacy_edit_wrap a, .pedit_del_icon, .pedit_set_icon, .feedback_row_menu_icon, .checkbox_official:after, .ui_actions_menu_sublist .ui_actions_menu_item.checked, .idd_wrap .idd_arrow, .market_like_icon, .market_share_icon, .photos_choose_upload_area_drop_label, .pe_editor .pe_tabs .pe_tab_icon, .pe_editor #pe_stickers_pack_tab_recent, .pe_editor #pe_stickers_pack_tab_editor, .mv_actions_block .download_control > .download_label img, .vk_vkopt_guide #top_vkopt_settings_link:before, .vk_vkopt_guide .top_profile_link:before, .vk_lastfm_icon, .lastfm_fav_icon, .vk_lastfm_playing_icon, .audio_album_edit_btn .audio_album_btn_icon, .audio_album_add_btn .audio_album_btn_icon, .audio_album_add_btn_icon, div#wpost_post_actions_wrap .post_comments_icon, div#wpost_post_actions_wrap .post_like_icon, div#wpost_post_actions_wrap .post_reply_icon, div#wpost_post_actions_wrap .post_share_icon, .datepicker_text, .im-mess.im-mess_search:hover:after, .intr_hide, .my_like .market_like_icon, .my_like .market_share_icon, .im-audio-message-btn, .upload_progress, .ui_search_new.ui_search_field_empty .ui_search_button_search, .ui_search_new .ui_search_reset_button, .ui_search_new .ui_search_params_button, .medadd_inline_editable_icon,  .im-chat-input .im-chat-input--attach-label, .emoji_smile_icon_vector, .ms_items_more_wrap.ms_items_more_wrap_vector .ms_item_more_label, .im-send-btn.im-send-btn_audio, .im-send-btn, .group_box_row .group_box_delete, .group_box_row .group_box_edit, .group_box_row .group_box_progress, .page_video_autoplay_tt_hide, .profile_warning_hide, .box_controls.group_age_disclaimer_box .flat_button.button_disabled, .im-page--back-btn, .feature_intro_tt_hide, .im-page--selected-messages-remove:before, .current_audio_cnt, .current_audio_cnt:hover, #marketplace .market_content .market_row .market_place_common_friend_badge, #marketplace .marketplace_icons .marketplace-icon, .im-fwd .im-fwd--close, .public_help_hide, .public_help_hide:hover, .wall_module .post_reply_icon, .video_upload_progress .video_upload_progress_cancel, .video_upload_tc_wrap .video_tc_upload_btn, .payments_box_close_lnk, .fave_link_actions_wrap .fave_link_delete:hover, .fave_link_actions_wrap .fave_link_progress:hover, .fave_link_actions_wrap .fave_link_delete, .fave_link_actions_wrap .fave_link_progress, .docs_action_icon:hover, .im-mess .im-mess--reply, .audio_page_layout .audio_page__add_audio_btn, .audio_page_layout .audio_page__add_playlist_btn, .audio_page_player .audio_page_player_share .btn_icon, .audio_page_player .audio_page_player_status .btn_icon, .audio_page_player .audio_page_player_recoms .btn_icon, .audio_page_player .audio_page_player_repeat .btn_icon, .audio_page_player .audio_page_player_shuffle .btn_icon, .audio_pl_snippet .audio_pl_snippet__action_btn_share, .audio_page_player .audio_page_player_add .btn_icon, .audio_page_player .audio_player_btn_added .btn_icon, .audio_row.hq .audio_hq_label, .audio_pl_snippet .audio_pl_snippet__action_btn_delete, .audio_pl_snippet .audio_pl_snippet__action_btn, .audio_pl_snippet .audio_pl_snippet__action_btn:hover, .audio_pl_snippet .audio_pl_snippet__action_btn_delete:hover, .shorten_list_delete_icon, .shorten_list_stats_icon, .audio_row .audio_row__action_current_delete, .audio_row .audio_row__action_delete, .audio_row .audio_row__action_listened_delete, .audio_row .audio_row__action_recoms_delete, .audio_row .audio_row__action_recoms, .audio_row .audio_row__action_edit, .audio_row .audio_row__action_next, .audio_row .audio_row__action_more, .audio_pl_snippet .audio_pl_snippet__more_btn:before, .audio_row .audio_row__action_add, .audio_row .audio_row__action_restore_listened, .audio_row .audio_row__action_restore_recoms, .im-right-menu .im-right-menu--close:before, .audio_row .audio_acts .audio_act.vk_audio_dl_btn>div, .audio_row__action_get_link div, .vk_au_msg_dl div, .im-page-action_delete, .im-page-action_star, .im-page-action_spam, .im-page .im-i--messages-search, a.group_app_button, a.group_app_button_multi, .im-page-pinned--hide, .im-page-pinned::before, .im-page-action_pin, .im-dropbox--icon-photo, .im-dropbox--icon-doc, .audio_page__shuffle_all .audio_page__shuffle_all_button:before, .im-mess .im-mess--edit, .im-mess--cancel-edit
  {
    -webkit-filter: var(--filt2);
    filter: var(--filt22);
  }

  .wall_module .post_views_icon
  {
    filter: saturate(0)brightness(1.4);
  }

  .sticker_hints_arrow, .stl_active.over_fast #stl_bg
  {
    opacity: 0.6;
  }

  .page_actions_cont.narrow .page_actions_header, .page_actions_cont.narrow .page_extra_actions_btn
  {
    background-image: var(--dots);
  }

  .exchange_subtab1.active, .exchange_subtab1.active:hover, .ads_nav .nav_selected, .ads_nav .nav_selected:hover, .ui_search_filters_pane .token .token_title
  {
    color: #111;
  }

  .slider .slider_loading_bar
  {
    -webkit-filter: saturate(0)brightness(0.15)opacity(0.7);
    filter: saturate(0)brightness(0.15)opacity(0.7);
  }

  .docs_item_icon, .friends_lists .friends_lists_group, .page_doc_row .page_doc_icon
  {
    -webkit-filter: brightness(0.7)saturate(1.5) !important;
    filter: brightness(0.7)saturate(1.5) !important;
  }
   /*[[style-color]]*/

  .checkbox_pic.facebook_pic.on, .im-page--back-btn:hover,.page_cover_image .ui_actions_menu_icons
  {
    -webkit-filter: none !important;
    filter: none !important;
  }

 @  -webkit-keyframes top_vkopt_settings_bg
  {
    from { background-color: var(--color2);
  }

  to
  {
    background-color: var(--color3);
  }
}

@-moz-keyframes top_vkopt_settings_bg
{
  from
  {
    background-color: var(--color2);
  }

  to
  {
    background-color: var(--color3);
  }
}

@-ms-keyframes top_vkopt_settings_bg
{
  from
  {
    background-color: var(--color2);
  }

  to
  {
    background-color: var(--color3);
  }
}

@-o-keyframes top_vkopt_settings_bg
{
  from
  {
    background-color: var(--color2);
  }

  to
  {
    background-color: var(--color3);
  }
}

@keyframes top_vkopt_settings_bg
{
  from
  {
    background-color: var(--color2);
  }

  to
  {
    background-color: var(--color3);
  }
}

/*=======================.wcomments===========================*/

.wcomments_page .post_date,.wcomments_page  .wall_module .reply_date,.wcomments_page  .wall_module .reply_to
{
  color: #939393;
}

.wcomments_page  .wall_reply_text
{
  color: #000;
}

.wcomments_page  .wr_header, .wcomments_page  .wr_header:hover
{
  background-color: #f0f2f5;
}

.wcomments_page div[contenteditable=true], .wcomments_page  .wall_module .reply_fakebox, .wcomments_page  .wall_module .reply_form
{
  background-color: #fff;
  border-color: #d3d9de;
}

.wcomments_page  .ui_actions_menu
{
  background: #fff;
  border-color: #c5d0db;
}

.wcomments_page  .ui_actions_menu_item:hover
{
  background-color: #e4eaf0;
}

.wcomments_page .submit_post
{
  background: #fafbfc;
  border-top: 1px solid #e7e8ec;
}

.wcomments_page .checkbox:before, wcomments_page .radiobtn:before
{
  -webkit-filter: none !important;
  filter: none !important;
}

.wcomments_page .flat_button
{
  background-color: #6888ad;
  color: #fff;
}

.wcomments_page .emoji_smile_icon, .wcomments_page  .media_selector .ms_item:before, .wcomments_page  .wall_module .post_like_icon, .wcomments_page .audio_play, .wcomments_page .wall_module .like_icon, .wcomments_page  .wall_module .reply_action, .wcomments_page  .wall_module .reply .reply_action:hover, .wcomments_page  .wall_module .reply_action
{
  -webkit-filter: none !important;
  filter: none !important;
}

.wcomments_page .post_author .author,.wcomments_page  .wall_module .author, .wcomments_page .wall_module .media_desc .a
{
  color: #42648b !important;
}

.wcomments_page .post_full_like_wrap .reply_link,.wcomments_page  .audio_row .audio_performer,.wcomments_page .audio_row:not(.audio_row_current):hover .audio_title_wrap, .wcomments_page a, .wcommunity_name .wcommunity_name_link, .wcomments_page .post_video_title, .wcomments_page .wall_module .my_like .post_like_count, .wcomments_page .wall_module .my_share .post_share_count, .wcomments_page .wall_module .my_like .like_count
{
  color: #2a5885;
}

.wcomments_page .audio_row:not(.audio_row_current):hover
{
  background-color: #f5f7fa;
}

.wcomments_page  .page_block, .wcomments_page .wall_module .reply_fakebox_wrap
{
  background-color: #fff;
  box-shadow: none;
}

/*-----widgetfix------*/

.widget_body .box_title_wrap.box_grey , .widget_body  .mention_tt_actions
{
  border-color: #ddd !important;
}

.widget_body #wpost_post, .widget_body  .box_body,.widget_body  .tt_default,.widget_body  .tt_default_right
{
  background-color: #fff !important;
  border-color: #ddd !important;
}

.widget_body .box_title_wrap.box_grey .box_title, .widget_body .box_title_wrap, .widget_body  .box_title_wrap.box_grey, .widget_body  .mention_tt_actions
{
  background-color: #f2f4f7 !important;
}

.widget_body .wpost_owner_head_link
{
  color: #42648b !important;
}

.widget_body, .widget_body .box_title_wrap.box_grey .box_title
{
  color: #000 !important;
}

.widget_body .post_like_icon,.widget_body .post_share_icon, .widget_body .post_comments_icon, .widget_body  .wall_signed_by, .widget_body  .box_title_wrap.box_grey .box_x_button
{
  -webkit-filter: none !important;
  filter: none !important;
}

.widget_body  .post_like,.widget_body .post_share, .widget_body  .post_comments,.widget_body .mention_tt_name
{
  color: #7996b5 !important;
}

.widget_body  .post_like:hover,.widget_body .post_share:hover, .widget_body  .post_comments:hover
{
  background: #f2f4f7 !important;
}

.widget_body  .flat_button
{
  background: #5e81a8;
  color: #fff !important;
}

.widget_body  .flat_button:hover
{
  background-color: #6888ad !important;
}

.widget_body  ::selection
{
  background-color: var(--color3);
  color: #ddd;
}

#share_cont
{
  height: 780px!important;
}

   /*[[different_font]]*/
   /*[[sidebar_only_icons]]*/
   /*[[bg_sidebar]]*/
   /*[[icons_off]]*/
   /*[[bright_font_color]]*/
   /*[[header_to_sidebar]]*/
   /*[[page_opacity]]*/
   /*[[alt_online]]*/
   /*[[coll_diag]]*/

.wall_module .post_like_icon, .wall_module .post_share_icon
{
  opacity: 0.3;
}

/*---ATTENTION---*/
.ui_actions_menu._ui_menu:hover
{
  box-shadow: 0 0 3px 1px rgba(255, 255, 255, .06);
}

/*------------------------temp-audiofix---------------------*/

.audio_row .audio_row_cover_wrap
{
  background-image: url('https://i.imgur.com/QOKBEBP.png');
}

.audio_page_player .audio_page_player__cover:not([style*="userapi.com"]), .audio_pl_attach_preview .audio_pl_attach_preview__cover, .audio_pl_snippet_play_small
{
  -webkit-filter: saturate(0)invert(0.85)brightness(0.9);
  filter: saturate(0)invert(0.85)brightness(0.9);
}

.audio_page_player .audio_page_player_repeat.audio_page_player_btn_enabled .btn_icon, .audio_page_player .audio_page_player_shuffle.audio_page_player_btn_enabled .btn_icon, .audio_page_player .audio_page_player_status.audio_page_player_btn_enabled .btn_icon
{
  -webkit-filter: saturate(0)brightness(3);
  filter: saturate(0)brightness(3);
}

.audio_pl_edit_box .ape_audio_item_wrap .ape_check .ape_check_icon, .audio_pl_snippet_play_small
{
  -webkit-filter: saturate(0)invert(1);
  filter: saturate(0)invert(1);
}

.audio_row.audio_hq .audio_row__duration:before
{
  filter: invert(1)saturate(0)brightness(1.5);
}

.audio_page_player .audio_page_player_play.audio_playing .icon
{
  background-image: url('data:image/svg+xml;charset=utf-8,<svg%20xmlns%3D"http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg"%20width%3D"28"%20height%3D"29"%20viewBox%3D"36%200%2028%2029"><g%20fill%3D"none"><path%20d%3D"M46%208.6C46%208.3%2046.3%208%2046.6%208L48.4%208C48.7%208%2049%208.3%2049%208.6L49%2019.4C49%2019.7%2048.7%2020%2048.4%2020L46.6%2020C46.3%2020%2046%2019.7%2046%2019.4L46%208.6ZM51%208.6C51%208.3%2051.3%208%2051.6%208L53.4%208C53.7%208%2054%208.3%2054%208.6L54%2019.4C54%2019.7%2053.7%2020%2053.4%2020L51.6%2020C51.3%2020%2051%2019.7%2051%2019.4L51%208.6Z"%20fill%3D"%23111"%2F><%2Fg><%2Fsvg>');
}

.audio_page_player .audio_page_player_play .icon
{
  background-image: url('data:image/svg+xml;charset=utf-8,<svg%20xmlns%3D"http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg"%20width%3D"28"%20height%3D"29"%20viewBox%3D"0%200%2028%2029"><g%20fill%3D"none"><path%20d%3D"M11.8%2019.9C11.4%2020.2%2011%2020%2011%2019.5L11%208.5C11%208%2011.4%207.8%2011.8%208.1L19.5%2013.6C19.9%2013.8%2019.8%2014.2%2019.5%2014.4L11.8%2019.9Z"%20fill%3D"%23111"%2F><%2Fg><%2Fsvg>');
}

.nim-dialog.nim-conversation-search-row
{
  height: 65px!important;
}

/*------------------------temp-audiofix---------------------*/
}
