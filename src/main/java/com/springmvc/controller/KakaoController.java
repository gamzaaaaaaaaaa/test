package com.springmvc.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

@WebServlet("/kakao/callback")
public class KakaoController extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String code = request.getParameter("code");

        // 카카오에 토큰 요청
        String tokenUrl = "https://kauth.kakao.com/oauth/token";
        String clientId = "dc92091a3ccad1db19071404a1ec4922"; // REST API 키
        String redirectUri = "http://localhost:8080/ibom/kakao/callback"; // 리다이렉트 URI

        try {
            URL url = new URL(tokenUrl);
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("POST");
            connection.setDoOutput(true);

            String postParams = "grant_type=authorization_code"
                    + "&client_id=" + clientId
                    + "&redirect_uri=" + redirectUri
                    + "&code=" + code;

            OutputStream os = connection.getOutputStream();
            os.write(postParams.getBytes());
            os.flush();
            os.close();

            int responseCode = connection.getResponseCode();
            if (responseCode == 200) {
                // 응답을 받아 토큰 처리
                BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream()));
                String inputLine;
                StringBuffer responseStr = new StringBuffer();

                while ((inputLine = in.readLine()) != null) {
                    responseStr.append(inputLine);
                }
                in.close();

                // JSON 파싱 (JSON 라이브러리 필요: Gson, Jackson 등)
                String jsonResponse = responseStr.toString();
                JSONObject jsonObject = new JSONObject(jsonResponse);

                String accessToken = jsonObject.getString("access_token");

                // 사용자 정보 요청
                String userInfo = getUserInfo(accessToken);

                // 사용자 정보 후처리 (예: DB 저장, 세션 생성)
                processUserInfo(userInfo);

                // 응답
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write("{\"success\":true}");
            } else {
                response.getWriter().write("{\"success\":false}");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("{\"success\":false}");
        }
    }

    private String getUserInfo(String accessToken) throws IOException {
        // 사용자 정보 요청
        String userInfoUrl = "https://kapi.kakao.com/v2/user/me";
        URL url = new URL(userInfoUrl);
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        connection.setRequestMethod("GET");
        connection.setRequestProperty("Authorization", "Bearer " + accessToken);

        BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream()));
        String inputLine;
        StringBuffer responseStr = new StringBuffer();

        while ((inputLine = in.readLine()) != null) {
            responseStr.append(inputLine);
        }
        in.close();

        return responseStr.toString();
    }

    private void processUserInfo(String userInfo) {
        // 사용자의 정보 처리 로직 (예: DB에 저장하거나 세션에 사용자 정보 저장)
        JSONObject jsonObject = new JSONObject(userInfo);
        String kakaoId = jsonObject.getJSONObject("id").toString();
        // 추가적인 사용자 정보 가져오기
        String email = jsonObject.getJSONObject("kakao_account").getString("email");
        // DB 저장 또는 세션에 저장
    }
}




