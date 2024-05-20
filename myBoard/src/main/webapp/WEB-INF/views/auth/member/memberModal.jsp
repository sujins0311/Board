<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<!-- 비밀번호변경 -->
<div class="modal fade" id="updatePWModal" tabindex="-1" role="dialog" aria-labelledby="updatePWModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="updatePWModalLabel">비밀번호 변경</h4>
			</div>
			<div class="modal-body">
                <form id="passwordChangeForm">
                    <div class="form-group">
                        <label for="currentPassword">이전 비밀번호</label>
                        <input type="password" class="form-control" id="currentPassword" 
                        name="currentPassword" required>
                    </div>
                    <div class="form-group">
                        <label for="newPassword">새 비밀번호</label>
                        <input type="password" class="form-control" id="newPassword" 
                        name="newPassword" required>
                    </div>
                    <div class="form-group">
                        <label for="confirmNewPassword">새 비밀번호 확인</label>
                        <input type="password" class="form-control" id="confirmNewPassword" 
                        name="confirmNewPassword" required>
                    </div>
                </form>
			</div>
			<div class="modal-footer">
				<button id="confirmSubmitBtn" type="button" class="btn btn-primary">확인</button>
				<button id='modalCloseBtn' type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>
<!-- /.modal -->



<!-- 회원탈퇴 -->
<div class="modal fade" id="deleteAccountModal" tabindex="-1" role="dialog" aria-labelledby="deleteAccountModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="deleteAccountModalLabel">회원 탈퇴</h4>
            </div>
            <div class="modal-body">정말로 회원 탈퇴를 하시겠습니까? 이 작업은 되돌릴 수 없습니다.</div>
            <div class="modal-footer">
                <button id="confirmDeleteBtn" type="button" class="btn btn-danger">탈퇴</button>
                <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!-- /.modal -->
