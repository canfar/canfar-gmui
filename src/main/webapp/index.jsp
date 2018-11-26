<%@ page language="java" contentType="text/html; charset=UTF-8" session="false" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

      <c:set var="baseURL" value='<%= System.getenv("CANFAR_WEB_HOST") %>' />

      <!-- Default to current host. -->
      <c:if test="${empty baseURL}">
        <c:set var="req" value="${pageContext.request}" />
        <c:set var="url">${req.requestURL}</c:set>
        <c:set var="uri" value="${req.requestURI}" />
        <c:set var="baseURL" value="${fn:substring(url, 0, fn:length(url) - fn:length(uri))}" />
      </c:if>

      <c:set var="contextPath" value="${pageContext.request.contextPath}" />

      <!DOCTYPE html>
      <html lang="en">

      <head>
        <meta charset='utf-8'>
        <meta http-equiv="X-UA-Compatible" content="chrome=1">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <base href="${fn:substring(url, 0, fn:length(url) - fn:length(uri))}${req.contextPath}/" />

        <c:import url="${baseURL}/canfar/includes/_page_top_styles.shtml" />

        <link rel="stylesheet" type="text/css" href="<c:out value=" ${baseURL}/cadcVOTV/css/slick.grid.css " />" media="screen" />
        <link rel="stylesheet" type="text/css" href="<c:out value=" ${baseURL}/cadcVOTV/css/slick.pager.css " />" media="screen" />
        <link rel="stylesheet" type="text/css" href="<c:out value=" ${baseURL}/cadcVOTV/css/jquery-ui-1.11.4.min.css " />" media="screen"
        />
        <link rel="stylesheet" type="text/css" href="<c:out value=" ${baseURL}/cadcVOTV/css/slick.columnpicker.css " />" media="screen"
        />
        <link rel="stylesheet" type="text/css" href="<c:out value=" ${baseURL}/cadcVOTV/css/cadc.votv.css " />" media="screen" />
        <link rel="stylesheet" type="text/css" href="${contextPath}/css/cadc.gms.css" media="screen" />

        <style type="text/css">
          html,
          body {
            width: 100%;
            height: 96%;
            left: 0;
            top: 0;
            bottom: 0;
            margin: auto;
          }

          .group_container div.modal-content,
          .associates div.modal-content {
            height: 400px;
          }

          .group_container div.modal-body,
          .associates div.modal-body {
            width: 600px;
          }

          .container {
            width: auto;
          }

          .fill {
            width: 100%;
            min-width: 100%;
            min-height: 98%;
            height: 98%;
            margin: auto;
          }

          .fill-mostly {
            margin: auto;
            width: 100%;
            min-width: 100%;
            min-height: 98%;
            height: 98%;
          }

          #group_list_grid {
            width: 100% !important;
            font-size: 1.0em;
            outline: 0;
            background: #fff;
            border: 1px solid gray;
            z-index: 100 !important;
          }

          #content_column_main {
            margin-top: 5px;
          }

          /**
      Used to determine column widths.
    */

          #lengthFinder {
            position: absolute;
            visibility: hidden;
            height: auto;
            font-size: 1.4em;
            /*width: auto;*/
            white-space: nowrap;

            /* Be generous with spacing. */
            /*font-size: 1.1em;*/
            font-family: Verdana, Arial, sans-serif;
          }

          .slick-header-column .slick-column-name {
            font-weight: normal;
          }
        </style>

        <script type="application/javascript" src="${contextPath}/js/jquery-2.2.4.min.js"></script>
        <script type="application/javascript" src="${contextPath}/js/bootstrap.min.js"></script>

        <!-- Internationalization libraries -->
        <script type="text/javascript" src="${contextPath}/js/jquery.i18n.js"></script>
        <script type="text/javascript" src="${contextPath}/js/jquery.i18n.messagestore.js"></script>
        <script type="text/javascript" src="${contextPath}/js/jquery.i18n.fallbacks.js"></script>
        <script type="text/javascript" src="${contextPath}/js/jquery.i18n.parser.js"></script>
        <script type="text/javascript" src="${contextPath}/js/jquery.i18n.emitter.js"></script>
        <script type="text/javascript" src="${contextPath}/js/jquery.i18n.language.js"></script>

        <!--[if lt IE 9]>
  <script src="/html5shiv.googlecode.com/svn/trunk/html5.js"></script>
  <![endif]-->
        <title>CANFAR</title>
      </head>

      <body>
        <c:import url="${baseURL}/canfar/includes/_application_header.shtml" />
        <div class="container-fluid fill">
          <div class="row fill">
            <div role="main" class="col-sm-12 col-md-12 main fill">
              <div class="inner fill">
                <section id="main_content" class="fill">

                  <h2>
                    <a id="canfar-beta" class="anchor" href="#canfar-beta" aria-hidden="true">
                      <span aria-hidden="true" class="octicon octicon-link"></span>
                    </a>Group Management
                  </h2>

                  <!-- Content starts -->
                  <!-- Add Group button -->
                  <button type="button" class="btn btn-primary" id="add_group_button" data-toggle="modal" data-target="#add_group_modal" disabled="disabled">
                    <span class="glyphicon glyphicon-plus"></span>
                    <span class="button_text"></span>
                  </button>

                  <div id="content_column_main" class="fill">
                    <div class="loader_container">
                      <div class="text-center">
                        <img src="images/ajax-loader.gif" alt="Loading" />
                      </div>
                      <div class="clear"></div>
                    </div>

                    <div id="content_column_main_inner" class="sr-only fill">
                      <div class="grid-container margin-top-medium fill">
                        <div id="group-results-grid-header" class="grid-header" style="width: 100%;">
                          <span class="grid-header-label"></span>
                        </div>
                        <div id="group_list_grid" class="fill-mostly"></div>
                      </div>
                    </div>
                    <div id="lengthFinder"></div>
                  </div>
                  <div id="new_group_container" class="group_container" data-operate="create">
                    <!-- Create Group modal -->
                    <div class="modal" id="add_group_modal" tabindex="-1" role="dialog">
                      <div class="modal-dialog" role="document">
                        <div class="modal-content">
                          <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                              <span aria-hidden="true">&times;</span>
                            </button>
                            <h4 class="modal-title" id="add_group_modal_label"></h4>
                          </div>
                          <div class="modal-body">
                            <form class="form-horizontal" method="post" action="${contextPath}/groups" name="groupForm">
                              <span class="form-message text-danger bg-danger"></span>
                              <!-- Group Name -->
                              <div class="form-group">
                                <label for="add_group_name" class="col-sm-2 control-label" id="add_group_name_label"></label>
                                <div class="col-sm-10">
                                  <input type="text" class="form-control" id="add_group_name" name="group-name" placeholder="Unique Group name" tabindex="1"
                                  />
                                </div>
                              </div>
                              <!-- Group Description -->
                              <div class="form-group">
                                <label for="add_group_description" class="col-sm-2 control-label" id="add_group_description_label"></label>
                                <div class="col-sm-10">
                                  <textarea class="form-control" id="add_group_description" name="group-description" tabindex="2"></textarea>
                                </div>
                              </div>
                              <!-- Buttons -->
                              <div class="form-group">
                                <div class="col-sm-offset-2 col-sm-10">
                                  <div class="btn-group" role="group">
                                    <button type="submit" class="btn btn-primary" id="add_group_update_button" value="SUBMIT_EXECUTE"></button>
                                    <input type="reset" class="btn btn-default" id="add_group_reset_button" />
                                    <button type="button" class="btn btn-default" id="add_group_close_button" data-dismiss="modal"></button>
                                  </div>
                                </div>
                              </div>
                            </form>
                          </div>
                          <div class="modal-footer">
                          </div>
                        </div>
                      </div>
                    </div>

                  </div>
                  <div id="edit_group_container" class="group_container" data-operate="update">
                    <!-- Update Group modal -->
                    <div class="modal" id="edit_group_modal" tabindex="-1" role="dialog">
                      <div class="modal-dialog" role="document">
                        <div class="modal-content">
                          <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                              <span aria-hidden="true">&times;</span>
                            </button>
                            <h4 class="modal-title" id="edit_group_modal_label"></h4>
                          </div>
                          <div class="modal-body">
                            <form class="form-horizontal" method="post" action="${contextPath}/groups" name="groupForm">

                              <span class="form-message text-danger bg-danger"></span>

                              <div class="loader_container">
                                <div class="text-center">
                                  <img src="images/ajax-loader.gif" alt="Loading" />
                                </div>
                              </div>

                              <!-- Group Name -->
                              <div class="form-group">
                                <label for="group_name" class="col-sm-2 control-label" id="edit_group_name_label"></label>
                                <div class="col-sm-10">
                                  <input type="text" class="form-control" disabled="disabled" id="group_name" name="group-name" tabindex="1" />
                                </div>
                              </div>
                              <!-- Group Description -->
                              <div class="form-group">
                                <label for="edit_group_description" class="col-sm-2 control-label" id="edit_group_description_label"></label>
                                <div class="col-sm-10">
                                  <textarea class="form-control" id="edit_group_description" name="group-description" tabindex="2"></textarea>
                                </div>
                              </div>
                              <!-- Buttons -->
                              <div class="form-group">
                                <div class="col-sm-offset-2 col-sm-10 ">
                                  <div class="btn-group action-button-group" role="group">
                                    <button type="submit" class="btn btn-primary" id="edit_group_update_button" value="SUBMIT_EXECUTE"></button>
                                    <input type="reset" class="btn btn-default" id="edit_group_reset_button" />
                                  </div>
                                  <div class="btn-group action-button-group" role="group">
                                    <button type="submit" class="btn btn-danger group-form-delete" id="edit_group_delete_button" value="DELETE"></button>
                                  </div>
                                  <div class="btn-group" role="group">
                                    <button type="button" class="btn btn-default" id="edit_group_close_button" data-dismiss="modal"></button>
                                  </div>
                                </div>
                              </div>
                            </form>
                          </div>
                          <div class="modal-footer">
                          </div>
                        </div>
                      </div>
                    </div>

                  </div>
                  <div id="edit_members_container" class="associates" data-association="members">
                    <!-- Update Member modal -->
                    <div class="modal" id="edit_members_modal" tabindex="-1" role="dialog">
                      <div class="modal-dialog" role="document">
                        <div class="modal-content">
                          <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                              <span aria-hidden="true">&times;</span>
                            </button>
                            <h4 class="modal-title" id="group_members_modal_label"></h4>
                          </div>
                          <div class="modal-body">
                            <!-- error messages -->
                            <div class=""></div>

                            <!-- loading image -->
                            <div class="loader_container">
                              <div class="text-center">
                                <img src="images/ajax-loader.gif" alt="Loading" />
                              </div>
                            </div>

                            <!-- Members grid -->
                            <div id="members_grid-container" class="grid-container fill" style="margin-bottom: 10px; width: 100%;">
                              <div id="members-results-grid-header" class="grid-header fill">
                                <span class="grid-header-label"></span>
                              </div>
                              <div id="members_grid" class="associate_grid" style="width: 100%;"></div>
                            </div>

                            <form class="form-inline" id="add-members-form" name="add-members-form" action="${contextPath}/group/" method="post">

                              <!-- members form -->
                              <div class="form-group">
                                <input type="hidden" name="assoc-type" />
                                <span class="ui-autocomplete-message text-danger bg-danger"></span>
                                <label for="members-search" class="sr-only" id="members-search_label"></label>
                                <input type="text" id="members-search" name="assoc-id" class="form-control assoc-search" placeholder="Enter a username or Group name"
                                  size="30" />
                                <button id="add_button_members" type="submit" class="btn btn-primary"></button>
                              </div>

                            </form>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div id="edit_admins_container" class="associates" data-association="admins">
                    <!-- Update Admin modal -->
                    <div class="modal" id="edit_admins_modal" tabindex="-1" role="dialog">
                      <div class="modal-dialog" role="document">
                        <div class="modal-content">
                          <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                              <span aria-hidden="true">&times;</span>
                            </button>
                            <h4 class="modal-title" id="group_admins_modal_label"></h4>
                          </div>
                          <div class="modal-body">
                            <!-- error messages -->
                            <div class=""></div>

                            <!-- loading image -->
                            <div class="loader_container">
                              <div class="text-center">
                                <img src="images/ajax-loader.gif" alt="Loading" />
                              </div>
                            </div>

                            <!-- admins grid -->
                            <div id="admins_grid-container" class="grid-container fill" style="margin-bottom: 10px; width: 100%;">
                              <div id="admins-results-grid-header" class="grid-header fill">
                                <span class="grid-header-label"></span>
                              </div>
                              <div id="admins_grid" class="associate_grid" style="width: 100%;"></div>
                            </div>

                            <form class="form-inline" id="add-admins-form" name="add-admins-form" action="${contextPath}/group/" method="post">

                              <!-- admins form -->
                              <div class="form-group">
                                <input type="hidden" name="assoc-type" />
                                <span class="ui-autocomplete-message text-danger bg-danger"></span>
                                <label for="admins-search" class="sr-only" id="admins-search_label"></label>
                                <input type="text" id="admins-search" name="assoc-id" class="form-control assoc-search" placeholder="Enter a username or Group name"
                                  size="30" />
                                <button id="add_button_admins" type="submit" class="btn btn-primary"></button>
                              </div>

                            </form>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>

                  <!-- Content ends -->

                </section>
              </div>
            </div>
          </div>
        </div>

        <script type="application/javascript" src="<c:out value=" ${baseURL}/cadcVOTV/javascript/jquery-ui-1.11.4.min.js " />"></script>
        <script type="application/javascript" src="<c:out value=" ${baseURL}/cadcVOTV/javascript/jquery.event.drag-2.2.min.js
          " />"></script>

        <script type="application/javascript" src="<c:out value=" ${baseURL}/cadcVOTV/javascript/slick.core.js " />"></script>
        <script type="application/javascript" src="<c:out value=" ${baseURL}/cadcVOTV/javascript/slick.grid.js " />"></script>
        <script type="application/javascript" src="<c:out value=" ${baseURL}/cadcVOTV/javascript/slick.dataview.js " />"></script>
        <script type="application/javascript" src="<c:out value=" ${baseURL}/cadcVOTV/javascript/slick.pager.js " />"></script>
        <script type="application/javascript" src="<c:out value=" ${baseURL}/cadcVOTV/javascript/slick.columnpicker.js " />"></script>
        <script type="application/javascript" src="<c:out value=" ${baseURL}/cadcVOTV/javascript/jquery.csv-0.71.min.js " />"></script>
        <script type="application/javascript" src="<c:out value=" ${baseURL}/cadcVOTV/javascript/cadc.rowselectionmodel.js " />"></script>
        <script type="application/javascript" src="<c:out value=" ${baseURL}/cadcVOTV/javascript/cadc.votable.js " />"></script>
        <script type="application/javascript" src="<c:out value=" ${baseURL}/cadcVOTV/javascript/cadc.votable-reader.js " />"></script>
        <script type="application/javascript" src="<c:out value=" ${baseURL}/cadcVOTV/javascript/cadc.plugin.filter_default.js " />"></script>
        <script type="application/javascript" src="<c:out value=" ${baseURL}/cadcVOTV/javascript/cadc.votv.js " />"></script>
        <script type="application/javascript" src="<c:out value=" ${baseURL}/cadcVOTV/javascript/cadc.votv.comparer.js " />"></script>

        <script type="text/javascript" src="${contextPath}/js/cadc.gms.js?version=@version@"></script>
        <script type="text/javascript" src="${contextPath}/js/cadc.gms.list.js?version=@version@"></script>

        <script type="application/javascript">
          $(document).ready(function() {
            var app = new App({grid_offset: 200})
            app.loadGroups()
          })
        </script>

      </body>

      </html>
