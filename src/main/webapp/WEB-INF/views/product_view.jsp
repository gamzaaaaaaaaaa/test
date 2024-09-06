<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="com.springmvc.domain.review"%>
<%@ page import="com.springmvc.domain.product_detail"%>
<%@ page import="com.springmvc.domain.product_connect_detail"%>
<%@ page import="java.util.List" %>

<% 
	String sessionId = (String)request.getAttribute("id");
	System.out.println(sessionId);
	List<review> reviews = (List<review>)request.getAttribute("review");
    product_detail product = (product_detail) request.getAttribute("product");
    
    int num = product.getProductId();
    System.out.println(num);

    if (product == null) {
        System.out.println("제품 정보를 가져올 수 없습니다.");
        return;
    }

    // 각 주의 레벨별 성분 개수 계산
    int highCount = 0;
    int mediumCount = 0;
    int lowCount = 0;

    for (product_connect_detail ingredient : product.getIngredients()) {
        switch (ingredient.getWarningLevel()) {
            case "high":
                highCount++;
                break;
            case "middle":
                mediumCount++;
                break;
            case "low":
                lowCount++;
                break;
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>제품 상세보기</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="/ibom/resources/css/product_view.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
    <style>
        #myform fieldset {
            display: inline-block;
            direction: rtl;
            border: 0;
        }

        #myform fieldset legend {
            text-align: right;
        }

        #myform input[type=radio] {
            display: none;
        }

        #myform label {
            font-size: 3em;
            color: transparent;
            text-shadow: 0 0 0 #f0f0f0;
        }

        #myform label:hover {
            text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
        }

        #myform label:hover ~ label {
            text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
        }

        #myform input[type=radio]:checked ~ label {
            text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
        }

        #reviewContents {
            width: 80%;
            height: 150px;
            padding: 10px;
            box-sizing: border-box;
            border: solid 1.5px #D3D3D3;
            border-radius: 5px;
            font-size: 16px;
            resize: none;
        }

        table {
            border-collapse: collapse;
            width: 100%;
        }

        table, td {
            border: none; /* 테이블 선 투명하게 */
        }

        td {
            padding: 10px;
        }

        .review-item {
            background-color: #fae9e3; /* 베이지 핑크 배경 */
            border-radius: 5px;
            padding: 10px;
            margin-bottom: 10px;
        }

        .rating-stars {
            color: #f5c518; /* 별점 색상 */
            font-size: 1.2em;
        }
        
        
    </style>
</head>
<body>
    <div>
        <jsp:include page="/navi.jsp" />

        <div class="p-5 rounded-3 outer-container">
            <div class="container-fluid py-5 text-center">
                <h1 class="display-5 fw-bold">우리 아이가 믿고 쓸 수 있는 안전한 제품</h1>
                <p class="col-md-8 fs-4 subtitle">엄마의 정성으로 선택한, 아이를 위한 최상의 선택</p>
            </div>
        </div>

        <nav class="navbar navbar-expand-lg navbar-light bg-light mb-4">
            <div class="container-fluid">
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav">
                        <li class="nav-item">
                            <a class="nav-link" href="/ibom/product/list?category=all&pageNum=1">전체보기</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="/ibom/product/list?category=lotion&pageNum=1">로션</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="/ibom/product/list?category=sun&pageNum=1">선케어</a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>

        <div class="container">
            <div class="row">
                <!-- 상품 정보 섹션 -->
                <div class="col-md-6">
                    <div class="product-info">
                        <div class="image-container mb-3">
                            <img src="/ibom/resources/images/<%= product.getImage() %>" alt="<%= product.getName() %>" class="img-fluid rounded">
                        </div>
                        <div class="text">
                            <p style="text-decoration : underline;"><%= product.getBrand() %></p>
                            <h5><%= product.getName() %></h5>
                            <p><strong>가격:</strong> <%= product.getPrice() %> 원</p>
                            <p><strong>구매링크:</strong> <a href="<%= product.getLink() %>" target="_blank"><%= product.getBrand() %></a></p>
                        </div>
                    </div>
                </div>

                <!-- 성분 정보 섹션 -->
                <div class="col-md-6">
                    <div class="accordion" id="accordionExample">
                        <!-- 높음 주의 -->
                        <div class="accordion-item high-warning">
                            <h2 class="accordion-header" id="headingHigh">
                                <button class="accordion-button" type="button" data-toggle="collapse" data-target="#collapseHigh" aria-expanded="true" aria-controls="collapseHigh">
                                    <i class="fa fa-exclamation-triangle"></i> 높음 주의
                                    <span class="badge fa ml-2 "><%= highCount %></span>
                                </button>
                            </h2>
                            <div id="collapseHigh" class="accordion-collapse collapse show" aria-labelledby="headingHigh" data-parent="#accordionExample">
                                <div class="accordion-body">
                                    <% 
                                        boolean hasHighWarning = false;
                                        for (product_connect_detail ingredient : product.getIngredients()) {
                                            if ("high".equals(ingredient.getWarningLevel())) {
                                                hasHighWarning = true;
                                                break;
                                            }
                                        }

                                        if (!hasHighWarning) {
                                    %>
                                    <p>해당 성분이 없습니다.</p>
                                    <% 
                                        } else {
                                            for (product_connect_detail ingredient : product.getIngredients()) {
                                                if ("high".equals(ingredient.getWarningLevel())) {
                                    %>
                                    <div class="ingredient-item">
                                        <i class="fa fa-exclamation-triangle"></i> 
                                        <strong><%= ingredient.getKorean() %></strong> <br>
                                        <small><%= ingredient.getEnglish() %></small>
                                    </div>
                                    <% 
                                                }
                                            }
                                        }
                                    %>
                                </div>
                            </div>
                        </div>

                        <!-- 중간 주의 -->
                        <div class="accordion-item medium-warning">
                            <h2 class="accordion-header" id="headingMedium">
                                <button class="accordion-button collapsed" type="button" data-toggle="collapse" data-target="#collapseMedium" aria-expanded="false" aria-controls="collapseMedium">
                                    <i class="fa fa-exclamation-circle"></i> 중간 주의
                                    <span class="badge fa text-dark ml-2"><%= mediumCount %></span>
                                </button>
                            </h2>
                            <div id="collapseMedium" class="accordion-collapse collapse" aria-labelledby="headingMedium" data-parent="#accordionExample">
                                <div class="accordion-body">
                                    <% 
                                        boolean hasMediumWarning = false;
                                        for (product_connect_detail ingredient : product.getIngredients()) {
                                            if ("middle".equals(ingredient.getWarningLevel())) {
                                                hasMediumWarning = true;
                                                break;
                                            }
                                        }

                                        if (!hasMediumWarning) {
                                    %>
                                    <p>해당 성분이 없습니다.</p>
                                    <% 
                                        } else {
                                            for (product_connect_detail ingredient : product.getIngredients()) {
                                                if ("middle".equals(ingredient.getWarningLevel())) {
                                    %>
                                    <div class="ingredient-item">
                                        <i class="fa fa-exclamation-circle"></i> 
                                        <strong><%= ingredient.getKorean() %></strong> <br>
                                        <small><%= ingredient.getEnglish() %></small>
                                    </div>
                                    <% 
                                                }
                                            }
                                        }
                                    %>
                                </div>
                            </div>
                        </div>

                        <!-- 낮음 주의 -->
                        <div class="accordion-item low-warning">
                            <h2 class="accordion-header" id="headingLow">
                                <button class="accordion-button collapsed" type="button" data-toggle="collapse" data-target="#collapseLow" aria-expanded="false" aria-controls="collapseLow">
                                    <i class="fa fa-info-circle"></i> 낮음 주의
                                    <span class="badge fa text-white ml-2"><%= lowCount %></span>
                                </button>
                            </h2>
                            <div id="collapseLow" class="accordion-collapse collapse" aria-labelledby="headingLow" data-parent="#accordionExample">
                                <div class="accordion-body">
                                    <% 
                                        boolean hasLowWarning = false;
                                        for (product_connect_detail ingredient : product.getIngredients()) {
                                            if ("low".equals(ingredient.getWarningLevel())) {
                                                hasLowWarning = true;
                                                break;
                                            }
                                        }

                                        if (!hasLowWarning) {
                                    %>
                                    <p>해당 성분이 없습니다.</p>
                                    <% 
                                        } else {
                                            for (product_connect_detail ingredient : product.getIngredients()) {
                                                if ("low".equals(ingredient.getWarningLevel())) {
                                    %>
                                    <div class="ingredient-item">
                                        <i class="fa fa-info-circle"></i> 
                                        <strong><%= ingredient.getKorean() %></strong> <br>
                                        <small><%= ingredient.getEnglish() %></small>
                                    </div>
                                    <% 
                                                }
                                            }
                                        }
                                    %>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            
                <!-- 리뷰 섹션 -->
                
                <form class="mb-3" name="myform" id="myform">
                <input type="hidden" id="reviewId" name="reviewId">
                    <fieldset class="field">
                        <span class="text-bold"></span>
                        <input type="radio" name="reviewStar" value=5 id="rate1"><label for="rate1">★</label>
                        <input type="radio" name="reviewStar" value=4 id="rate2"><label for="rate2">★</label>
                        <input type="radio" name="reviewStar" value=3 id="rate3"><label for="rate3">★</label>
                        <input type="radio" name="reviewStar" value=2 id="rate4"><label for="rate4">★</label>
                        <input type="radio" name="reviewStar" value=1 id="rate5"><label for="rate5">★</label>
                    </fieldset>
                
                    <div class="input-group mt-3">
                        <textarea class="form-control" type="text" id="reviewContents"
                                  placeholder="제품과 무관한 댓글, 악플은 삭제될 수 있습니다."></textarea>
                        <div class="input-group-append">
                            <button class="btn" id="submitReview" style="background-color: #a87e6e; color: white; ">작성</button>
                            <button class="btn" id="updateReview" style="background-color: #a87e6e; color: white; display:none">수정</button>
                        </div>
                    </div>
                </form>
                
                
                <div id="contentBox" class="col-md-12">
                    <% 
                       for (review rv : reviews) { 
                    %>
                    <div class="review-item">
                        <table>
                            <tr>
                                <td align="left" width="5%">
                                    <i class="fas fa-user" style="color: #a87e6e; font-size:25px;"></i>
                                    <span style="padding-left:20px; width:90%"><%= rv.getId() %></span>
                                </td>
                                <% if (sessionId != null && sessionId.equals(rv.getId())) { %>
                                <td align="center" width="1%" rowspan="3">
                                    <button onclick="updateReview(<%=rv.getNum() %>)" class="btn" id="updatebtn">수정</button>
                                    <button onclick="deleteReview(<%=rv.getNum() %>)" class="btn" id="deletebtn">삭제</button>
                                </td>
                                <% } %>
                            </tr>
                            <tr>
                                <td align="left">
                                    <span class="rating-stars">
                                        <% 
                                        int rating = rv.getScore();
                                        for (int i = 0; i < 5; i++) {
                                            if (i < rating) {
                                        %>
                                            ★
                                        <% 
                                            } else {
                                        %>
                                            ☆
                                        <% 
                                            }
                                        } 
                                        %>
                                    </span>
                                    <span><%= rv.getRegistDay() %></span>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4"><%= rv.getContent() %></td>
                            </tr>
                        </table>
                    </div>
                    <% } %>  
                </div>
            
            </div>
        </div>

        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
    </div>
    
<script>
    var btn = document.querySelector("#submitReview");
    var id = "<%= sessionId %>";
    var parents_num = <%= num %>;

    btn.addEventListener("click", function(e) {
        e.preventDefault();

        var score = document.querySelector('input[name="reviewStar"]:checked').value;
        var content = document.querySelector("#reviewContents").value;

        if (!score) {
            alert("별점을 선택해주세요.");
            return;  
        }

        if (!content) {
            alert("내용을 작성해주세요.");
            return;
        }

        if (!id || id === "null") {
            alert("로그인이 필요합니다.");
            var currentUrl = window.location.href;
            window.location.href = "/ibom/login?redirect=" + encodeURIComponent(currentUrl);
            return;
        }

        var formData = {
            num: parents_num,
            sessionId: id,  
            score: parseInt(score, 10),
            content: content
        };

        $.ajax({
            type: "POST",
            url: "/ibom/product/review",  
            data: JSON.stringify(formData),
            contentType: "application/json",
            success: function(response) {
                updateReviewTable(response);
                console.log(response);
            },
            error: function(err) {
                alert("리뷰 작성 실패");
            }
        });
    });


    var sessionId = "<%= sessionId %>";  

    function updateReviewTable(reviews) {
        var contentBox = document.querySelector("#contentBox");

        contentBox.innerHTML = '';

        reviews.forEach(function(rv) {
            var stars = generateStars(rv.score);

            var reviewHtml = 
                '<div class="review-item" data-review-id="' + rv.num + '">' +
                    '<table style="width: 100%; border: none;">' +
                        '<tr>' +
                            '<td align="left" width="5%">' +
                                '<i class="fas fa-user" style="color: #a87e6e; font-size:25px;"></i>' +
                                '<span style="padding-left:20px; width:90%">' + rv.id + '</span>' +
                            '</td>';

            if (sessionId && sessionId === rv.id) {
                reviewHtml += 
                            '<td align="center" width="1%" rowspan="3">' +
                                '<button onclick="updateReview(' + rv.num + ')" class="btn">수정</button>' +
                                '<button onclick="deleteReview(' + rv.num + ')" class="btn">삭제</button>' +
                                		
                            '</td>';
            }

            reviewHtml += '</tr>' +
                        '<tr>' +
                            '<td align="left">' +
                                '<span class="rating-stars">' + stars + '</span>' +
                                '<span>' + rv.registDay + '</span>' +
                            '</td>' +
                        '</tr>' +
                        '<tr>' +
                            '<td colspan="4">' + rv.content + '</td>' +
                        '</tr>' +
                    '</table>' +
                '</div>';

            contentBox.innerHTML += reviewHtml;
        });
    }


	// 별점 생성 함수
	function generateStars(score) {
	    var stars = "";
	    for (var i = 0; i < 5; i++) {
	        if (i < score) {
	            stars += "★";  
	        } else {
	            stars += "☆"; 
	        }
	    }
	    return stars;
	}
	
	
	function updateReview(num) {
	    $.ajax({
	        type: "GET",
	        url: "/ibom/product/reviewread",  
	        data:  { num: num },
	        success: function(review) {
	            document.querySelector("#reviewContents").value = review.content;
	            document.querySelector('input[name="reviewStar"][value="' + review.score + '"]').checked = true;
	            document.querySelector("#reviewId").value = review.num;

	            // 제출 버튼 숨기기, 수정 버튼 보이기
	            var submitReview = document.querySelector("#submitReview");
	            var updateReview = document.querySelector("#updateReview");
	            submitReview.style.display = "none";
	            updateReview.style.display = "block";
	        },
	        error: function(err) {
	            alert("리뷰 읽어오기 실패");
	        }
	    });

	    // 수정 버튼 클릭 시 수정된 리뷰를 서버로 전송
	    document.querySelector("#updateReview").addEventListener("click", function(e) {
	        e.preventDefault();

	        var score = document.querySelector('input[name="reviewStar"]:checked').value;
	        var content = document.querySelector("#reviewContents").value;
	        var reviewId = document.querySelector("#reviewId").value;
			console.log(reviewId);
			
	        var data = {
	            num: parseInt(reviewId, 10), 
	            parents_num: parents_num,
	            sessionId: id,  
	            score: parseInt(score, 10),
	            content: content
	        };

	        // 서버로 수정된 리뷰 데이터 전송
	        $.ajax({
	            type: "POST",
	            url: "/ibom/product/reviewupdate",  
	            data: JSON.stringify(data),
	            contentType: "application/json",
	            success: function(response) {
	            	console.log(response);
	                updateReviewTable(response); // 리뷰 목록 업데이트
	                alert("리뷰가 수정되었습니다.");
	                
	                var submitReview = document.querySelector("#submitReview");
		            var updateReview = document.querySelector("#updateReview");
		            submitReview.style.display = "block";
		            updateReview.style.display = "none";
		            document.querySelector("#reviewContents").value = '';
		            var starInputs = document.querySelectorAll('input[name="reviewStar"]');
		            starInputs.forEach(function(input) {
		                input.checked = false;
		            });
		            document.querySelector("#reviewId").value = '';
	            },
	            error: function(err) {
	                alert("리뷰 수정 실패");
	            }
	        });
	    });
	}


</script>

</body>
</html>
