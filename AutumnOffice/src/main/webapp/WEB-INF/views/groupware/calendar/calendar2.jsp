<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   


<%--     <link rel="stylesheet" href="${cPath}/resources/FullCalendar/vendor/css/fullcalendar.min.css" /> --%>
<%--     <link rel="stylesheet" href="${cPath}/resources/FullCalendar/vendor/css/bootstrap.min.css"> --%>
<%--     <link rel="stylesheet" href='${cPath}/resources/FullCalendar/vendor/css/select2.min.css' /> --%>
<%--     <link rel="stylesheet" href='${cPath}/resources/FullCalendar/vendor/css/bootstrap-datetimepicker.min.css' /> --%>

<!--     <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Open+Sans:400,500,600"> -->
<!--     <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons"> -->

<%--     <link rel="stylesheet" href="${cPath}/resources/FullCalendar/css/main.css"> --%>
    
<%--     <script type="text/javascript" src='${cPath}/resources/FullCalendar/vendor/js/jquery.min.js'></script> --%>
<%--     <script src="${cPath}/resources/FullCalendar/vendor/js/bootstrap.min.js"></script> --%>
<%--     <script src="${cPath}/resources/FullCalendar/vendor/js/moment.min.js"></script> --%>
<%--     <script src="${cPath}/resources/FullCalendar/vendor/js/fullcalendar.min.js"></script> --%>
<%--     <script src="${cPath}/resources/FullCalendar/vendor/js/ko.js"></script> --%>
<%--     <script src="${cPath}/resources/FullCalendar/vendor/js/select2.min.js"></script> --%>
<%--     <script src="${cPath}/resources/FullCalendar/vendor/js/bootstrap-datetimepicker.min.js"></script> --%>
<%--     <script src="${cPath}/resources/FullCalendar/js/main.js"></script> --%>

    
 

    <div class="container">

        <!-- 일자 클릭시 메뉴오픈 / 아이디에 클릭 이벤트 준듯 -->
        <div  id="contextMenu" class="dropdown clearfix"> 
            <ul class="dropdown-menu dropNewEvent" role="menu" aria-labelledby="dropdownMenu"
                style="display:block;position:static;margin-bottom:5px;">
                <li><a tabindex="-1" href="#">카테고리1</a></li>
                <li><a tabindex="-1" href="#">카테고리2</a></li>
                <li><a tabindex="-1" href="#">카테고리3</a></li>
                <li><a tabindex="-1" href="#">카테고리4</a></li>
                <li class="divider"></li>
                <li><a tabindex="-1" href="#" data-role="close">Close</a></li>
            </ul>
        </div>

        <div id="wrapper">
            <div id="loading"></div>
            <div id="calendar"></div>
        </div>


        <!-- 일정 추가 MODAL -->
        <div class="modal fade" tabindex="-1" role="dialog" id="eventModal">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                                aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title"></h4>
                    </div>
                    <div class="modal-body">

                        <div class="row">
                            <div class="col-xs-12">
                                <label class="col-xs-4" for="edit-allDay">하루종일</label>
                                <input class='allDayNewEvent' id="edit-allDay" type="checkbox"></label>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-xs-12">
                                <label class="col-xs-4" for="edit-title">일정명</label>
                                <input class="inputModal" type="text" name="edit-title" id="edit-title"
                                    required="required" />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <label class="col-xs-4" for="edit-start">시작</label>
                                <input class="inputModal" type="text" name="edit-start" id="edit-start" />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <label class="col-xs-4" for="edit-end">끝</label>
                                <input class="inputModal" type="text" name="edit-end" id="edit-end" />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <label class="col-xs-4" for="edit-type">구분</label>
                                <select class="inputModal" type="text" name="edit-type" id="edit-type">
                                    <option value="카테고리1">카테고리1</option>
                                    <option value="카테고리2">카테고리2</option>
                                    <option value="카테고리3">카테고리3</option>
                                    <option value="카테고리4">카테고리4</option>
                                </select>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <label class="col-xs-4" for="edit-color">색상</label>
                                <select class="inputModal" name="color" id="edit-color">
                                    <option value="#D25565" style="color:#D25565;">빨간색</option>
                                    <option value="#9775fa" style="color:#9775fa;">보라색</option>
                                    <option value="#ffa94d" style="color:#ffa94d;">주황색</option>
                                    <option value="#74c0fc" style="color:#74c0fc;">파란색</option>
                                    <option value="#f06595" style="color:#f06595;">핑크색</option>
                                    <option value="#63e6be" style="color:#63e6be;">연두색</option>
                                    <option value="#a9e34b" style="color:#a9e34b;">초록색</option>
                                    <option value="#4d638c" style="color:#4d638c;">남색</option>
                                    <option value="#495057" style="color:#495057;">검정색</option>
                                </select>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <label class="col-xs-4" for="edit-desc">설명</label>
                                <textarea rows="4" cols="50" class="inputModal" name="edit-desc"
                                    id="edit-desc"></textarea>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer modalBtnContainer-addEvent">
                        <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
                        <button type="button" class="btn btn-primary" id="save-event">저장</button>
                    </div>
                    <div class="modal-footer modalBtnContainer-modifyEvent">
                        <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
                        <button type="button" class="btn btn-danger" id="deleteEvent">삭제</button>
                        <button type="button" class="btn btn-primary" id="updateEvent">저장</button>
                    </div>
                </div><!-- /.modal-content -->
            </div><!-- /.modal-dialog -->
        </div><!-- /.modal -->




















        <div class="panel panel-default">

            <div class="panel-heading">
                <h3 class="panel-title">필터</h3>
            </div>

            <div class="panel-body">

                <div class="col-lg-6">
                    <label for="calendar_view">구분별</label>
                    <div class="input-group">
                        <select class="filter" id="type_filter" multiple="multiple">
                            <option value="카테고리1">카테고리1</option>
                            <option value="카테고리2">카테고리2</option>
                            <option value="카테고리3">카테고리3</option>
                            <option value="카테고리4">카테고리4</option>
                        </select>
                    </div>
                </div>

                <div class="col-lg-6">
                <button type="button" class="btn btn-primary" id="insert">추가</button>
                    <label for="calendar_view">등록자별</label>
                    <div class="input-group">
                        <label class="checkbox-inline"><input class='filter' type="checkbox" value="a0001"
                                checked>a0001</label>
                        <label class="checkbox-inline"><input class='filter' type="checkbox" value="다현"
                                checked>다현</label>
                        <label class="checkbox-inline"><input class='filter' type="checkbox" value="사나"
                                checked>사나</label>
                        <label class="checkbox-inline"><input class='filter' type="checkbox" value="나연"
                                checked>나연</label>
                        <label class="checkbox-inline"><input class='filter' type="checkbox" value="지효"
                                checked>지효</label>
                    </div>
                </div>

            </div>
        </div>
        <!-- /.filter panel -->
    </div>
    <!-- /.container -->
    <script>
    let draggedEventIsAllDay;
    let activeInactiveWeekends = true;

    let calendar = $('#calendar').fullCalendar({

     /***************************************************************************
    	 * OPTIONS
    	 **************************************************************************/
      locale                    : 'ko',    
      timezone                  : "local", 
      nextDayThreshold          : "09:00:00",
      allDaySlot                : true,
      displayEventTime          : true,
      displayEventEnd           : true,
      firstDay                  : 0, // 월요일이 먼저 오게 하려면 1
      weekNumbers               : false,
      selectable                : true,
      weekNumberCalculation     : "ISO",
      eventLimit                : true,
      views                     : { 
                                    month : { eventLimit : 12 } // 한 날짜에 최대 이벤트 12개,
    															// 나머지는 + 처리됨
                                  },
      eventLimitClick           : 'week', // popover
      navLinks                  : true,
      defaultDate               : moment('2019-05'), // 실제 사용시 현재 날짜로 수정
      timeFormat                : 'HH:mm',
      defaultTimedEventDuration : '01:00:00',
      editable                  : true,
      minTime                   : '00:00:00',
      maxTime                   : '24:00:00',
      slotLabelFormat           : 'HH:mm',
      weekends                  : true,
      nowIndicator              : true,
      dayPopoverFormat          : 'MM/DD dddd',
      longPressDelay            : 0,
      eventLongPressDelay       : 0,
      selectLongPressDelay      : 0,  
      header                    : {
                                    left   : 'today, prevYear, nextYear, viewWeekends',
                                    center : 'prev, title, next',
                                    right  : 'month, agendaWeek, agendaDay, listWeek'
                                  },
      views                     : {
                                    month : {
                                      columnFormat : 'dddd'
                                    },
                                    agendaWeek : {
                                      columnFormat : 'M/D ddd',
                                      titleFormat  : 'YYYY년 M월 D일',
                                      eventLimit   : false
                                    },
                                    agendaDay : {
                                      columnFormat : 'dddd',
                                      eventLimit   : false
                                    },
                                    listWeek : {
                                      columnFormat : ''
                                    }
                                  },
      customButtons             : { // 주말 숨기기 & 보이기 버튼
                                    viewWeekends : {
                                      text  : '주말',
                                      click : function () {
                                        activeInactiveWeekends ? activeInactiveWeekends = false : activeInactiveWeekends = true;
                                        $('#calendar').fullCalendar('option', { 
                                          weekends: activeInactiveWeekends
                                        });
                                      }
                                    }
                                   },


      eventRender: function (event, element, view) {

        // 일정에 hover시 요약
        // 일정 위에 커서 놓으면 실행
        element.popover({
          title: $('<div />', {
            class: 'popoverTitleCalendar',
            text: event.title
          }).css({
            'background': event.backgroundColor,
            'color': event.textColor
          }),
          content: $('<div />', {
              class: 'popoverInfoCalendar'
            }).append('<p><strong>등록자:</strong> ' + event.username + '</p>')
            .append('<p><strong>구분:</strong> ' + event.type + '</p>')
            .append('<p><strong>시간:</strong> ' + getDisplayEventDate(event) + '</p>')
            .append('<div class="popoverDescCalendar"><strong>설명:</strong> ' + event.description + '</div>'),
          delay: {
            show: "800",
            hide: "50"
          },
          trigger: 'hover',
          placement: 'top',
          html: true,
          container: 'body'
        });

        return filtering(event);

      },

      /***************************************************************************
    	 * 일정 받아옴 **************
    	 */
      events: function (start, end, timezone, callback) {
        $.ajax({
          type: "get",

          url: "${cPath}/calendar/calendarList2.do",
          data: {
            // 화면이 바뀌면 Date 객체인 start, end 가 들어옴
            // startDate : moment(start).format('YYYY-MM-DD'),
            // endDate : moment(end).format('YYYY-MM-DD')
          },
          dataType : "json",
          success: function (response) {
        	  console.log(response);
            let fixedDate = response.map(function (array) {
            	if(array.allDay ==1){
            		array.allDay =true;
            	}else{
            		array.allDay =false;
            	}
            	
            	console.log(array);
              if (array.allDay && array.start !== array.end) {
                array.end = moment(array.end).add(1, 'days'); // 이틀 이상 AllDay 일정인
    															// 경우 달력에 표기시 하루를
    															// 더해야 정상출력 이유는 모름 
              }
              return array;
            });
            callback(fixedDate);
          }
        });
      },

      eventAfterAllRender: function (view) {
        if (view.name == "month") $(".fc-content").css('height', 'auto');
      },

      // 일정 리사이즈
      eventResize: function (event, delta, revertFunc, jsEvent, ui, view) {
        $('.popover.fade.top').remove();

        /**
    	 * 리사이즈시 수정된 날짜반영 하루를 빼야 정상적으로 반영됨.
    	 */
        let newDates = calDateWhenResize(event);

        // 리사이즈한 일정 업데이트
        $.ajax({
          type: "get",
          url: "",
          data: {
            // id: event._id,
            // ....
          },
          success: function (response) {
        	  alert("zzzzz");
            alert('수정: ' + newDates.startDate + ' ~ ' + newDates.endDate);
          }
        });

      },

      eventDragStart: function (event, jsEvent, ui, view) {
        draggedEventIsAllDay = event.allDay;
      },

      // 일정 드래그앤드롭
      eventDrop: function (event, delta, revertFunc, jsEvent, ui, view) {
        $('.popover.fade.top').remove();

        // 주,일 view일때 종일 <-> 시간 변경불가
        if (view.type === 'agendaWeek' || view.type === 'agendaDay') {
          if (draggedEventIsAllDay !== event.allDay) {
            alert('드래그앤드롭으로 종일<->시간 변경은 불가합니다.');
            location.reload();
            return false;
          }
        }

        // 드랍시 수정된 날짜반영
        let newDates = calDateWhenDragnDrop(event);
      

        let dropData = {
        		testId:  event._id,
        		testTitle: event.title,
        		testStart: newDates.startDate,
        		testEnd: newDates.endDate,
        		testDescription: event.description,
        		testType: event.type,
        		testUsername: event.username,//실제 구현에서는 로그인된 이름으로 일정추가?
        		testBackgroundcolor: event.backgroundColor,
        		testTextcolor: '#ffffff',
                testAllday: event.allDay
            };
       
        if(dropData.testAllday==true){
        	dropData.testAllday = 1;
        }else{
        	dropData.testAllday = 0;
        }
        
        // 드롭한 일정 업데이트
        $.ajax({
          type: "post",
          url: "${cPath}/calendar/calendarUpdate.do",
          data: dropData ,
          success: function (response) {
        	 
            alert('수정: ' + newDates.startDate + ' ~ ' + newDates.endDate);
            location.href = "${cPath}/calendar/calendarList.do";
          }
        });

      },

      select: function (startDate, endDate, jsEvent, view) {

        $(".fc-body").unbind('click');
        $(".fc-body").on('click', 'td', function (e) {

          $("#contextMenu")
            .addClass("contextOpened")
            .css({
              display: "block",
              left: e.pageX,
              top: e.pageY
            });
          return false;
        });

        let today = moment();

        if (view.name == "month") {
          startDate.set({
            hours: today.hours(),
            minute: today.minutes()
          });
          startDate = moment(startDate).format('YYYY-MM-DD HH:mm');
          endDate = moment(endDate).subtract(1, 'days');

          endDate.set({
            hours: today.hours() + 1,
            minute: today.minutes()
          });
          endDate = moment(endDate).format('YYYY-MM-DD HH:mm');
        } else {
          startDate = moment(startDate).format('YYYY-MM-DD HH:mm');
          endDate = moment(endDate).format('YYYY-MM-DD HH:mm');
        }

        // 날짜 클릭시 카테고리 선택메뉴
        let $contextMenu = $("#contextMenu");
        $contextMenu.on("click", "a", function (e) {
          e.preventDefault();

          // 닫기 버튼이 아닐때
          if ($(this).data().role !== 'close') {
            newEvent(startDate, endDate, $(this).html());
          }

          $contextMenu.removeClass("contextOpened");
          $contextMenu.hide();
        });

        $('body').on('click', function () {
          $contextMenu.removeClass("contextOpened");
          $contextMenu.hide();
        });

      },

      // 이벤트 클릭시 수정이벤트
      eventClick: function (event, jsEvent, view) {
        editEvent(event);
      }

    });

    function getDisplayEventDate(event) {

      let displayEventDate;

      if (event.allDay == false) {
        let startTimeEventInfo = moment(event.start).format('HH:mm');
        let endTimeEventInfo = moment(event.end).format('HH:mm');
        displayEventDate = startTimeEventInfo + " - " + endTimeEventInfo;
      } else {
        displayEventDate = "하루종일";
      }

      return displayEventDate;
    }

    function filtering(event) {
      let show_username = true;
      let show_type = true;

      let username = $('input:checkbox.filter:checked').map(function () {
        return $(this).val();
      }).get();
      let types = $('#type_filter').val();

      show_username = username.indexOf(event.username) >= 0;

      if (types && types.length > 0) {
        if (types[0] == "all") {
          show_type = true;
        } else {
          show_type = types.indexOf(event.type) >= 0;
        }
      }

      return show_username && show_type;
    }

    function calDateWhenResize(event) {

      let newDates = {
        startDate: '',
        endDate: ''
      };

      if (event.allDay) {
        newDates.startDate = moment(event.start._d).format('YYYY-MM-DD');
        newDates.endDate = moment(event.end._d).subtract(1, 'days').format('YYYY-MM-DD');
      } else {
        newDates.startDate = moment(event.start._d).format('YYYY-MM-DD HH:mm');
        newDates.endDate = moment(event.end._d).format('YYYY-MM-DD HH:mm');
      }

      return newDates;
    }

    function calDateWhenDragnDrop(event) {
      // 드랍시 수정된 날짜반영
      let newDates = {
        startDate: '',
        endDate: ''
      }

      // 날짜 & 시간이 모두 같은 경우
      if(!event.end) {
        event.end = event.start;
      }

      // 하루짜리 all day
      if (event.allDay && event.end === event.start) {
        console.log('1111')
        newDates.startDate = moment(event.start._d).format('YYYY-MM-DD');
        newDates.endDate = newDates.startDate;
      }

      // 2일이상 all day
      else if (event.allDay && event.end !== null) {
        newDates.startDate = moment(event.start._d).format('YYYY-MM-DD');
        newDates.endDate = moment(event.end._d).subtract(1, 'days').format('YYYY-MM-DD');
      }

      // all day가 아님
      else if (!event.allDay) {
        newDates.startDate = moment(event.start._d).format('YYYY-MM-DD HH:mm');
        newDates.endDate = moment(event.end._d).format('YYYY-MM-DD HH:mm');
      }

      return newDates;
      
    }
    
//========================================================addEvent.js======================================================


let eventModal = $('#eventModal');

let modalTitle = $('.modal-title');
let editAllDay = $('#edit-allDay');
let editTitle = $('#edit-title');
let editStart = $('#edit-start');
let editEnd = $('#edit-end');
let editType = $('#edit-type');
let editColor = $('#edit-color');
let editDesc = $('#edit-desc');

let addBtnContainer = $('.modalBtnContainer-addEvent');
let modifyBtnContainer = $('.modalBtnContainer-modifyEvent');


/* ****************
 *  새로운 일정 생성
 * ************** */
let newEvent = function (start, end, eventType) {

    $("#contextMenu").hide(); //메뉴 숨김

    modalTitle.html('새로운 일정');
    editType.val(eventType).prop('selected', true);
    editTitle.val('');
    editStart.val(start);
    editEnd.val(end);
    editDesc.val('');
    
    addBtnContainer.show();
    modifyBtnContainer.hide();
    eventModal.modal('show');


    //새로운 일정 저장버튼 클릭
    $('#save-event').unbind();
    $('#save-event').on('click', function () {

//         let eventData = {
//             _id: eventId,
//             title: editTitle.val(),
//             start: editStart.val(),
//             end: editEnd.val(),
//             description: editDesc.val(),
//             type: editType.val(),
//             username: '사나',//실제 구현에서는 로그인된 이름으로 일정추가?
//             backgroundColor: editColor.val(),
//             textColor: '#ffffff',
//             allDay: 0
//         };

        
        let eventData = {
//         		testId: eventId,
        		testTitle: editTitle.val(),
        		testStart: editStart.val(),
        		testEnd: editEnd.val(),
        		testDescription: editDesc.val(),
        		testType: editType.val(),
        		testUsername: '사나',//실제 구현에서는 로그인된 이름으로 일정추가?
        		testBackgroundcolor: editColor.val(),
        		testTextcolor: '#ffffff',
                testAllday: 0
            };

        if (eventData.testStart > eventData.testEnd) {
            alert('끝나는 날짜가 앞설 수 없습니다.');
            return false;
        }

        if (eventData.testTitle === '') {
            alert('일정명은 필수입니다.');
            return false;
        }

        let realEndDay;

        if (editAllDay.is(':checked')) {
        	//체크 되어 있으면 뒤에 시간을 없애야 하니까 format 
            eventData.testStart = moment(eventData.testStart).format('YYYY-MM-DD');

            eventData.testEnd = moment(eventData.testEnd).format('YYYY-MM-DD');

            eventData.testAllday = 1;
        } else{
        	eventData.testAllday = 0;
        }

        eventModal.find('input, textarea').val('');
        editAllDay.prop('checked', false);
        eventModal.modal('hide');

        //새로운 일정 저장
        $.ajax({
            type: "post",
            url: "${cPath}/calendar/calendarInsert.do",
            data: eventData,
            success: function (response) {
            	console.log(response);
            	 location.href = "${cPath}/calendar/calendarList.do"
                //DB연동시 중복이벤트 방지를 위한
                //$('#calendar').fullCalendar('removeEvents');
                //$('#calendar').fullCalendar('refetchEvents');
            }
        });
    });
};
    	
//===================================================편집=====================================================
//===================================================편집=====================================================
//===================================================편집=====================================================
			

let editEvent = function (event, element, view) {

    $('#deleteEvent').data('id', event._id); //클릭한 이벤트 ID
    $('#updateEvent').data('id', event._id);
    $('.popover.fade.top').remove();
    $(element).popover("hide");

    if (event.allDay === true) {
        editAllDay.prop('checked', true);
    } else {
        editAllDay.prop('checked', false);
    }

    if (event.end === null) {
        event.end = event.start;
    }

    if (event.allDay === true && event.end !== event.start) {
//         editEnd.val(moment(event.end).subtract(1, 'days').format('YYYY-MM-DD HH:mm'))
        editEnd.val(moment(event.end).format('YYYY-MM-DD HH:mm'));
    } else {
        editEnd.val(event.end.format('YYYY-MM-DD HH:mm'));
    }

    modalTitle.html('일정 수정');
    editTitle.val(event.title);
    editStart.val(event.start.format('YYYY-MM-DD HH:mm'));
    editType.val(event.type);
    editDesc.val(event.description);
    editColor.val(event.backgroundColor).css('color', event.backgroundColor);

    addBtnContainer.hide();
    modifyBtnContainer.show();
    eventModal.modal('show');

    //업데이트 버튼 클릭시
    $('#updateEvent').unbind();
    $('#updateEvent').on('click', function () {
//     	alert("여기임?");

        if (editStart.val() > editEnd.val()) {
            alert('끝나는 날짜가 앞설 수 없습니다.');
            return false;
        }

        if (editTitle.val() === '') {
            alert('일정명은 필수입니다.')
            return false;
        }

        let statusAllDay;
        let startDate;
        let endDate;
        let displayDate;

        if (editAllDay.is(':checked')) {
            statusAllDay = true;
            startDate = moment(editStart.val()).format('YYYY-MM-DD');
            endDate = moment(editEnd.val()).subtract(1,'days').format('YYYY-MM-DD'); //수정을 하면 1일씩 늘어나서 1을 빼줬음

        } else {
            statusAllDay = false;
            startDate = editStart.val();
            endDate = editEnd.val();
           
        }

        eventModal.modal('hide');

        event.allDay = statusAllDay;
        event.title = editTitle.val();
        event.start = startDate;
        event.end = endDate;
        event.type = editType.val();
        event.backgroundColor = editColor.val();
        event.description = editDesc.val();
		
        
        
        
        let modifiedData = {
        		testId:  $(this).data('id'),
        		testTitle: event.title,
        		testStart: event.start,
        		testEnd: event.end,
        		testDescription: event.description,
        		testType: event.type,
        		testUsername: event.username,//실제 구현에서는 로그인된 이름으로 일정추가?
        		testBackgroundcolor: event.backgroundColor,
        		testTextcolor: '#ffffff',
                testAllday: event.allDay
            };
         if(modifiedData.testAllday==true){
        	 modifiedData.testAllday = 1;
         }else{
        	 modifiedData.testAllday = 0;
         }

        //일정 업데이트
        $.ajax({
            type: "post",
            url: "${cPath}/calendar/calendarUpdate.do",
            data: modifiedData,
            success: function (response) {
                alert('수정완료');
                location.href = "${cPath}/calendar/calendarList.do"
            }
        });

    });
};

// =========================삭제버튼===============================================
// =========================삭제버튼===============================================
// =========================삭제버튼===============================================	
$('#deleteEvent').on('click', function () {
    
    $('#deleteEvent').unbind();
    let deleteId = $(this).data('id');
//     $("#calendar").fullCalendar('removeEvents', $(this).data('id'));
    eventModal.modal('hide');

    //삭제시
    $.ajax({
        type: "post",
        url: "${cPath}/calendar/calendarDelete.do",
        data: {
        	testId : deleteId
        },
        success: function (response) {
            alert('삭제되었습니다!');
            location.href = "${cPath}/calendar/calendarList.do"
        }
    });

});	
    	
    	
    	
    	</script>


<%--     <script src="${cPath}/resources/FullCalendar/js/addEvent.js"></script> --%>
<%--     <script src="${cPath}/resources/FullCalendar/js/editEvent.js"></script> --%>
<%--     <script src="${cPath}/resources/FullCalendar/js/etcSetting.js"></script> --%>

