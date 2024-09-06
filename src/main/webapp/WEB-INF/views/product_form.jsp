<%@ page contentType="text/html; charset=utf-8"%>

<html>
<head>
    <link rel="stylesheet" type="text/css" href="/ibom/resources/css/board_form.css">
    <title>Product Registration</title>
</head>
<script type="text/javascript">
    function checkForm() {
        if (!document.productForm.name.value) {
            alert("제품 이름을 입력하세요.");
            return false;
        }
        if (!document.productForm.price.value) {
            alert("가격을 입력하세요.");
            return false;
        }
        if (!document.productForm.brand.value) {
            alert("브랜드를 입력하세요.");
            return false;
        }
        if (!document.productForm.category.value) {
            alert("카테고리를 선택하세요.");
            return false;
        }
        if (!document.productForm.link.value) {
            alert("제품 링크를 입력하세요.");
            return false;
        }
        return true;
    }
</script>
<body>
<div class="container py-4">
    <jsp:include page="/navi.jsp" />
    
    <div class="p-5 mb-4 rounded-3 outer-container">
        <div class="container-fluid py-5">
            <h1 class="display-5 fw-bold">제품 등록</h1>
            <p class="col-md-8 fs-4">상품 정보를 입력하세요</p>
        </div>
    </div>

    <div class="row align-items-md-stretch text-center">     
        <form name="productForm" action="/product/register" method="post" enctype="multipart/form-data" onsubmit="return checkForm()">
            <!-- 제품 이름 -->
            <div class="mb-3 row">
                <label class="col-sm-2 control-label">제품 이름</label>
                <div class="col-sm-5">
                    <input name="name" type="text" class="form-control" placeholder="제품 이름을 입력하세요" required>
                </div>
            </div>

            <!-- 가격 -->
            <div class="mb-3 row">
                <label class="col-sm-2 control-label">가격</label>
                <div class="col-sm-5">
                    <input name="price" type="number" class="form-control" placeholder="가격을 입력하세요" required>
                </div>
            </div>

            <!-- 브랜드 -->
            <div class="mb-3 row">
                <label class="col-sm-2 control-label">브랜드</label>
                <div class="col-sm-5">
                    <input name="brand" type="text" class="form-control" placeholder="브랜드를 입력하세요" required>
                </div>
            </div>

            <!-- 카테고리 선택 -->
            <div class="mb-3 row">
                <label class="col-sm-2 control-label">카테고리</label>
                <div class="col-sm-5">
                    <select name="category" class="form-control" required>
                        <option value="lotion">로션</option>
                        <option value="sun">선케어</option>
                        <!-- 더 많은 카테고리가 추가될 수 있음 -->
                    </select>
                </div>
            </div>

            <!-- 제품 링크 -->
            <div class="mb-3 row">
                <label class="col-sm-2 control-label">제품 링크</label>
                <div class="col-sm-5">
                    <input name="link" type="url" class="form-control" placeholder="제품 링크를 입력하세요" required>
                </div>
            </div>

            <!-- 제품 이미지 -->
            <div class="mb-3 row">
                <label class="col-sm-2 control-label">제품 이미지</label>
                <div class="col-sm-5">	
                    <input name="image" type="file" class="form-control" required>
                </div>
            </div>

            <!-- 성분 선택 -->
            <div class="mb-3 row">
                <label class="col-sm-2 control-label">성분 선택 (경고 수준별로)</label>
                <div class="col-sm-8 text-left">
                    <!-- High Level 성분 -->
                    <h5>High Level</h5>
                    <div class="checkbox-group">
                        <div>
                            <label>
                                <input type="checkbox" name="ingredients" value="1"> 성분 1 (Paraben)
                            </label>
                        </div>
                        <div>
                            <label>
                                <input type="checkbox" name="ingredients" value="2"> 성분 2 (Formaldehyde)
                            </label>
                        </div>
                        <!-- 추가할 수 있는 성분들 -->
                    </div>

                    <!-- Middle Level 성분 -->
                    <h5>Middle Level</h5>
                    <div class="checkbox-group">
                        <div>
                            <label>
                                <input type="checkbox" name="ingredients" value="3"> 성분 3 (Sulfate)
                            </label>
                        </div>
                        <div>
                            <label>
                                <input type="checkbox" name="ingredients" value="4"> 성분 4 (Phthalates)
                            </label>
                        </div>
                        <!-- 추가할 수 있는 성분들 -->
                    </div>

                    <!-- Low Level 성분 -->
                    <h5>Low Level</h5>
                    <div class="checkbox-group">
                        <div>
                            <label>
                                <input type="checkbox" name="ingredients" value="5"> 성분 5 (Aloe Vera)
                            </label>
                        </div>
                        <div>
                            <label>
                                <input type="checkbox" name="ingredients" value="6"> 성분 6 (Glycerin)
                            </label>
                        </div>
                        <!-- 추가할 수 있는 성분들 -->
                    </div>
                </div>
            </div>

            <!-- 제출 및 취소 버튼 -->
            <div class="mb-3 row" style="padding-top:2%">
                <div class="col-sm-offset-2 col-sm-10">
                    <input type="submit" class="btn btn-primary" value="등록" style="background-color:#a87e6e; border:none; padding:12px 20px;">                
                    <input type="reset" class="btn btn-primary" value="취소" style="background-color:#a87e6e; border:none; padding:12px 20px">
                </div>
            </div>
        </form>
    </div>
</div>
</body>
</html>
