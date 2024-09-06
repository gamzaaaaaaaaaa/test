<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.springmvc.domain.reservation" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Page</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="/ibom/resources/css/hospital_info.css">
    <style>
        /* 버튼의 좌우 여백을 줄이고, 모달 버튼과 일치시키기 위해 수정 */
        .btn-action {
            margin: 0 5px; /* 좌우 여백 조정 */
        }

        /* 모달 내 버튼들 정렬 */
        .modal-footer {
            display: flex;
            justify-content: flex-end; /* 오른쪽 정렬 */
            align-items: center; /* 수직 중앙 정렬 */
        }

        .modal-footer .btn {
            margin-left: 10px; /* 버튼 간 간격 조정 */
        }
    </style>
</head>
<body>
<%
    List<reservation> rv = (List<reservation>)request.getAttribute("reserve");
%>
    <div class="sidebar">
        <h4>Menu</h4>
        <a href="/ibom/mypage">내 정보 보기</a>
        <a href="/ibom/childpage">내 아이 정보</a>
        <a href="/ibom/hospitalinfo">병원 예약 확인</a>
    </div>
    <div class="content">
        <div class="container">
            <h1 class="text-center">Hospital Reservation</h1>
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>이름</th>
                        <th>병원명</th>
                        <th>예약 날짜</th>
                        <th>예약 시간</th>
                        <th>작업</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        for (reservation reservation : rv) {
                    %>
                        <tr>
                            <td><%= reservation.getName() %></td>
                            <td><%= reservation.getHospitalName() %></td>
                            <td><%= reservation.getDate() %></td>
                            <td><%= reservation.getTime() %></td>
                            <td>
                                <button type="button" class="btn btn-primary btn-action" data-bs-toggle="modal" data-bs-target="#editModal" data-id="<%= reservation.getId() %>" data-date="<%= reservation.getDate() %>" data-time="<%= reservation.getTime() %>">수정</button>
                                <button type="button" class="btn btn-danger btn-action" data-bs-toggle="modal" data-bs-target="#deleteModal" data-id="<%= reservation.getId() %>" data-date="<%= reservation.getDate() %>" data-time="<%= reservation.getTime() %>">삭제</button>
                            </td>
                        </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
            <!-- 홈으로 이동 버튼 추가 -->
            <a href="/ibom" class="btn btn-primary w-100">Home</a>
        </div>
    </div>

    <!-- Edit Modal -->
    <div class="modal fade" id="editModal" tabindex="-1" aria-labelledby="editModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editModalLabel">예약 수정</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p>예약을 수정하시겠습니까?</p>
                </div>
                <div class="modal-footer">
                    <form id="editForm" method="get">
                        <input type="hidden" id="editId" name="id">
                        <input type="hidden" id="editDate" name="date">
                        <input type="hidden" id="editTime" name="time">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                        <button type="submit" class="btn btn-primary">수정</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Delete Modal -->
    <div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="deleteModalLabel">예약 삭제</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p>예약을 삭제하시겠습니까?</p>
                </div>
                <div class="modal-footer">
                    <form id="deleteForm" method="get" action="/ibom/reservation/delete">
                        <input type="hidden" id="deleteId" name="id">
                        <input type="hidden" id="deleteDate" name="date">
                        <input type="hidden" id="deleteTime" name="time">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                        <button type="submit" class="btn btn-danger">삭제</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Edit Modal 데이터 설정
        document.getElementById('editModal').addEventListener('show.bs.modal', function (event) {
            var button = event.relatedTarget;
            var id = button.getAttribute('data-id');
            var date = button.getAttribute('data-date');
            var time = button.getAttribute('data-time');
            var modal = this;
            modal.querySelector('#editId').value = id;
            modal.querySelector('#editDate').value = date;
            modal.querySelector('#editTime').value = time;
            modal.querySelector('#editForm').action = "/ibom/reservation/edit?id=" + id + "&date=" + date + "&time=" + time;
        });

        // Delete Modal 데이터 설정
        document.getElementById('deleteModal').addEventListener('show.bs.modal', function (event) {
            var button = event.relatedTarget;
            var id = button.getAttribute('data-id');
            var date = button.getAttribute('data-date');
            var time = button.getAttribute('data-time');
            var modal = this;
            modal.querySelector('#deleteId').value = id;
            modal.querySelector('#deleteDate').value = date;
            modal.querySelector('#deleteTime').value = time;
            modal.querySelector('#deleteForm').action = "/ibom/reservation/delete?id=" + id + "&date=" + date + "&time=" + time;
        });
    </script>
</body>
</html>
