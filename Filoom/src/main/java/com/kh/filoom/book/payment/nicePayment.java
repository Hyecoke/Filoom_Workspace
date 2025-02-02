package com.kh.filoom.book.payment;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.kh.filoom.book.controller.BookController;
import com.kh.filoom.book.model.service.BookService;
import com.kh.filoom.book.model.vo.Booking;

import lombok.extern.slf4j.Slf4j;


@Slf4j
@Component
public class nicePayment {
	
	
	// 상점키
	private String merchantKey 		= "EYzu8jGGMfqaDEp76gSckuvnaHHu+bC4opsSN6lHv3b2lurNYkVXrZ7Z1AoqQnXI3eLuaUFyoRNC6FkrzVjceg==";
	// 상점아이디
	private String merchantID 		= "nicepay00m";
	
	@Autowired
	private BookService bookService;
	
	@Autowired
	private DataEncrypt sha256Enc;

	
	
	//나이스페이먼츠 결제 진행 메소드
		//결제정보, 좌석테스트결과, 쿠폰테스트결과를 받아 결제 진행 : 성공 true/실패 false 반환
	 	
	public boolean payment(Map<String, String> request, //결제시 필요한 인증결과 데이터
								  boolean seatTest, //좌석유효성 검사 결과
								  int couponTest //쿠폰테스트 결과 0,1,2(실패)
								  ) throws Exception {
		
		
		String amt = (String)request.get("Amt");
		boolean paySuccess = false;
		
		if(amt.equals("0")) { //결제 0인경우
			if(!seatTest || couponTest==2) { //둘중 하나라도 실패시   
				paySuccess = false;
			}else {
				paySuccess = true;
			}
			
		}else { //결제금액있는경우
			/*
			****************************************************************************************
			* <인증 결과 파라미터>
			****************************************************************************************
			*/
			
			String authResultCode 	= (String)request.get("AuthResultCode"); 	// 인증결과 : 0000(성공)

			if(!seatTest || couponTest==2) { //둘중 하나라도 실패시   
				authResultCode = null;
			}
			
			String authResultMsg 	= (String)request.get("AuthResultMsg"); 	// 인증결과 메시지
			String nextAppURL 		= (String)request.get("NextAppURL"); 		// 승인 요청 URL
			String txTid 			= (String)request.get("TxTid"); 			// 거래 ID
			String authToken 		= (String)request.get("AuthToken"); 		// 인증 TOKEN
			String payMethod 		= (String)request.get("PayMethod"); 		// 결제수단
			String mid 				= (String)request.get("MID"); 				// 상점 아이디
			String moid 			= (String)request.get("Moid"); 			// 상점 주문번호
			 				// 결제 금액o
			String reqReserved 		= (String)request.get("ReqReserved"); 		// 상점 예약필드
			String netCancelURL 	= (String)request.get("NetCancelURL"); 	// 망취소 요청 URL
			//String authSignature = (String)request.getParameter("Signature");			// Nicepay에서 내려준 응답값의 무결성 검증 Data
			

			/*  
			****************************************************************************************
			* Signature : 요청 데이터에 대한 무결성 검증을 위해 전달하는 파라미터로 허위 결제 요청 등 결제 및 보안 관련 이슈가 발생할 만한 요소를 방지하기 위해 연동 시 사용하시기 바라며 
			* 위변조 검증 미사용으로 인해 발생하는 이슈는 당사의 책임이 없음 참고하시기 바랍니다.
			****************************************************************************************
			 */
			DataEncrypt sha256Enc 	= new DataEncrypt();
			String merchantKey 		= "EYzu8jGGMfqaDEp76gSckuvnaHHu+bC4opsSN6lHv3b2lurNYkVXrZ7Z1AoqQnXI3eLuaUFyoRNC6FkrzVjceg=="; // 상점키
			
			//인증 응답 Signature = hex(sha256(AuthToken + MID + Amt + MerchantKey)
			//String authComparisonSignature = sha256Enc.encrypt(authToken + mid + amt + merchantKey);

			/*
			****************************************************************************************
			* <승인 결과 파라미터 정의>
			* 샘플페이지에서는 승인 결과 파라미터 중 일부만 예시되어 있으며, 
			* 추가적으로 사용하실 파라미터는 연동메뉴얼을 참고하세요.
			****************************************************************************************
			*/
			String ResultCode 	= ""; String ResultMsg 	= ""; String PayMethod 	= "";
			String GoodsName 	= ""; String Amt 		= ""; String TID 		= ""; 
			//String Signature = ""; String paySignature = "";


			/*
			****************************************************************************************
			* <인증 결과 성공시 승인 진행>
			****************************************************************************************
			*/
			
			String resultJsonStr = "";
			if(authResultCode.equals("0000") /*&& authSignature.equals(authComparisonSignature)*/){
				/*
				****************************************************************************************
				* <해쉬암호화> (수정하지 마세요)
				* SHA-256 해쉬암호화는 거래 위변조를 막기위한 방법입니다. 
				****************************************************************************************
				*/
				String ediDate			= getyyyyMMddHHmmss();
				String signData 		= sha256Enc.encrypt(authToken + mid + amt + ediDate + merchantKey);

				/*
				****************************************************************************************
				* <승인 요청>
				* 승인에 필요한 데이터 생성 후 server to server 통신을 통해 승인 처리 합니다.
				****************************************************************************************
				*/
				StringBuffer requestData = new StringBuffer();
				requestData.append("TID=").append(txTid).append("&");
				requestData.append("AuthToken=").append(authToken).append("&");
				requestData.append("MID=").append(mid).append("&");
				requestData.append("Amt=").append(amt).append("&");
				requestData.append("EdiDate=").append(ediDate).append("&");
				requestData.append("CharSet=").append("utf-8").append("&");
				requestData.append("SignData=").append(signData);

				resultJsonStr = connectToServer(requestData.toString(), nextAppURL);

				HashMap resultData = new HashMap();
				
				if("9999".equals(resultJsonStr)){
					/*
					*************************************************************************************
					* <망취소 요청>
					* 승인 통신중에 Exception 발생시 망취소 처리를 권고합니다.
					*************************************************************************************
					*/
					StringBuffer netCancelData = new StringBuffer();
					requestData.append("&").append("NetCancel=").append("1");
					String cancelResultJsonStr = connectToServer(requestData.toString(), netCancelURL);
					
					HashMap cancelResultData = jsonStringToHashMap(cancelResultJsonStr);
					ResultCode = (String)cancelResultData.get("ResultCode");
					ResultMsg = (String)cancelResultData.get("ResultMsg");
					/*Signature = (String)cancelResultData.get("Signature");
					String CancelAmt = (String)cancelResultData.get("CancelAmt");
					paySignature = sha256Enc.encrypt(TID + mid + CancelAmt + merchantKey);*/
				}else{
					resultData = jsonStringToHashMap(resultJsonStr);
					ResultCode 	= (String)resultData.get("ResultCode");	// 결과코드 (정상 결과코드:3001)
					ResultMsg 	= (String)resultData.get("ResultMsg");	// 결과메시지
					PayMethod 	= (String)resultData.get("PayMethod");	// 결제수단
					GoodsName   = (String)resultData.get("GoodsName");	// 상품명
					Amt       	= (String)resultData.get("Amt");		// 결제 금액
					TID       	= (String)resultData.get("TID");		// 거래번호
					// Signature : Nicepay에서 내려준 응답값의 무결성 검증 Data
					// 가맹점에서 무결성을 검증하는 로직을 구현하여야 합니다.
					/*Signature = (String)resultData.get("Signature");
					paySignature = sha256Enc.encrypt(TID + mid + Amt + merchantKey);*/
					
					/*
					*************************************************************************************
					* <결제 성공 여부 확인>
					*************************************************************************************
					*/
					if(PayMethod != null){
						if(PayMethod.equals("CARD")){
							if(ResultCode.equals("3001")) paySuccess = true; // 신용카드(정상 결과코드:3001)
						}else if(PayMethod.equals("BANK")){
							if(ResultCode.equals("4000")) paySuccess = true; // 계좌이체(정상 결과코드:4000)	
						}else if(PayMethod.equals("CELLPHONE")){
							if(ResultCode.equals("A000")) paySuccess = true; // 휴대폰(정상 결과코드:A000)	
						}else if(PayMethod.equals("VBANK")){
							if(ResultCode.equals("4100")) paySuccess = true; // 가상계좌(정상 결과코드:4100)
						}else if(PayMethod.equals("SSG_BANK")){
							if(ResultCode.equals("0000")) paySuccess = true; // SSG은행계좌(정상 결과코드:0000)
						}else if(PayMethod.equals("CMS_BANK")){
							if(ResultCode.equals("0000")) paySuccess = true; // 계좌간편결제(정상 결과코드:0000)
						}
					}
				}
			}else/*if(authSignature.equals(authComparisonSignature))*/{  //인증결과 실패시
				ResultCode 	= authResultCode; 	
				ResultMsg 	= authResultMsg;
			}/*else{
				System.out.println("인증 응답 Signature : " + authSignature);
				System.out.println("인증 생성 Signature : " + authComparisonSignature);
			}*/
		}
		log.debug("결제메소드 실행 결과 결제금액 : "+amt+"원, 결제결과 성공유무 : "+paySuccess);
		
		return paySuccess;
	}
	
	
	
	//결제 취소 나이스페이 API 
	//취소 성공시 true / 실패시 false
	//
	public boolean cancelPayment(Booking booking) throws Exception {
		
		
		boolean cancelResult = false;
		/*
		****************************************************************************************
		* <취소요청 파라미터>
		* 취소시 전달하는 파라미터입니다.
		* 샘플페이지에서는 기본(필수) 파라미터만 예시되어 있으며, 
		* 추가 가능한 옵션 파라미터는 연동메뉴얼을 참고하세요.
		****************************************************************************************
		*/
		String tid 					= booking.getCostTid();
								  //= (String)request.getParameter("TID");	// 거래 ID
		String cancelAmt 			= booking.getBookCost()+"";
								  //= (String)request.getParameter("CancelAmt");	// 취소금액
		String partialCancelCode 	=  "0";
								  //=(String)request.getParameter("PartialCancelCode"); 	// 부분취소여부
		String mid 					= merchantID;
								  //= "nicepay00m";	// 상점 ID
		String moid					= booking.getBookNo()+"";
								  //= "nicepay_api_3.0_test";	// 주문번호
		String cancelMsg 			= "고객요청";	// 취소사유
		
		/*
		****************************************************************************************
		* <해쉬암호화> (수정하지 마세요)
		* SHA-256 해쉬암호화는 거래 위변조를 막기위한 방법입니다. 
		****************************************************************************************
		*/
		DataEncrypt sha256Enc 	= new DataEncrypt();
		String merchantKey 		= "EYzu8jGGMfqaDEp76gSckuvnaHHu+bC4opsSN6lHv3b2lurNYkVXrZ7Z1AoqQnXI3eLuaUFyoRNC6FkrzVjceg=="; // 상점키
		String ediDate			= getyyyyMMddHHmmss();
		String signData 		= sha256Enc.encrypt(mid + cancelAmt + ediDate + merchantKey);
		
		/*
		****************************************************************************************
		* <취소 요청>
		* 취소에 필요한 데이터 생성 후 server to server 통신을 통해 취소 처리 합니다.
		* 취소 사유(CancelMsg) 와 같이 한글 텍스트가 필요한 파라미터는 euc-kr encoding 처리가 필요합니다.
		****************************************************************************************
		*/
		StringBuffer requestData = new StringBuffer();
		requestData.append("TID=").append(tid).append("&");
		requestData.append("MID=").append(mid).append("&");
		requestData.append("Moid=").append(moid).append("&");
		requestData.append("CancelAmt=").append(cancelAmt).append("&");
		requestData.append("CancelMsg=").append(URLEncoder.encode(cancelMsg, "euc-kr")).append("&");
		requestData.append("PartialCancelCode=").append(partialCancelCode).append("&");
		requestData.append("EdiDate=").append(ediDate).append("&");
		requestData.append("CharSet=").append("utf-8").append("&");
		requestData.append("SignData=").append(signData);
		String resultJsonStr = connectToServer(requestData.toString(), "https://pg-api.nicepay.co.kr/webapi/cancel_process.jsp");
		
		/*
		****************************************************************************************
		* <취소 결과 파라미터 정의>
		* 샘플페이지에서는 취소 결과 파라미터 중 일부만 예시되어 있으며, 
		* 추가적으로 사용하실 파라미터는 연동메뉴얼을 참고하세요.
		****************************************************************************************
		*/
		String ResultCode 	= ""; String ResultMsg 	= ""; String CancelAmt 	= "";
		String CancelDate 	= ""; String CancelTime = ""; String TID 		= ""; String Signature = "";
		
		/*  
		****************************************************************************************
		* Signature : 요청 데이터에 대한 무결성 검증을 위해 전달하는 파라미터로 허위 결제 요청 등 결제 및 보안 관련 이슈가 발생할 만한 요소를 방지하기 위해 연동 시 사용하시기 바라며 
		* 위변조 검증 미사용으로 인해 발생하는 이슈는 당사의 책임이 없음 참고하시기 바랍니다.
		****************************************************************************************
		 */
		//String Signature = ""; String cancelSignature = "";
		
		if("9999".equals(resultJsonStr)){
			ResultCode 	= "9999";
			ResultMsg	= "통신실패";
			cancelResult = false;
		}else{
			HashMap resultData = jsonStringToHashMap(resultJsonStr);
			ResultCode 	= (String)resultData.get("ResultCode");	// 결과코드 (취소성공: 2001, 취소성공(LGU 계좌이체):2211)
			ResultMsg 	= (String)resultData.get("ResultMsg");	// 결과메시지
			CancelAmt 	= (String)resultData.get("CancelAmt");	// 취소금액
			CancelDate 	= (String)resultData.get("CancelDate");	// 취소일
			CancelTime 	= (String)resultData.get("CancelTime");	// 취소시간
			TID 		= (String)resultData.get("TID");		// 거래아이디 TID
			//Signature       	= (String)resultData.get("Signature");
			//cancelSignature = sha256Enc.encrypt(TID + mid + CancelAmt + merchantKey);
			cancelResult = true;
		}
				
				
		return cancelResult;
	}

	
	
	
	
	
	
	//결제시 필요한 정보 암호화 메소드
	public final synchronized String getyyyyMMddHHmmss(){
		SimpleDateFormat yyyyMMddHHmmss = new SimpleDateFormat("yyyyMMddHHmmss");
		return yyyyMMddHHmmss.format(new Date());
	}
	
	
	//server to server 통신
	public String connectToServer(String data, String reqUrl) throws Exception{
		HttpURLConnection conn 		= null;
		BufferedReader resultReader = null;
		PrintWriter pw 				= null;
		URL url 					= null;
		
		int statusCode = 0;
		StringBuffer recvBuffer = new StringBuffer();
		try{
			url = new URL(reqUrl);
			conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("POST");
			conn.setConnectTimeout(15000);
			conn.setReadTimeout(25000);
			conn.setDoOutput(true);
			
			pw = new PrintWriter(conn.getOutputStream());
			pw.write(data);
			pw.flush();
			
			statusCode = conn.getResponseCode();
			resultReader = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"));
			for(String temp; (temp = resultReader.readLine()) != null;){
				recvBuffer.append(temp).append("\n");
			}
			
			if(!(statusCode == HttpURLConnection.HTTP_OK)){
				throw new Exception();
			}
			
			return recvBuffer.toString().trim();
		}catch (Exception e){
			return "9999";
		}finally{
			recvBuffer.setLength(0);
			
			try{
				if(resultReader != null){
					resultReader.close();
				}
			}catch(Exception ex){
				resultReader = null;
			}
			
			try{
				if(pw != null) {
					pw.close();
				}
			}catch(Exception ex){
				pw = null;
			}
			
			try{
				if(conn != null) {
					conn.disconnect();
				}
			}catch(Exception ex){
				conn = null;
			}
		}
	}

	//JSON String -> HashMap 변환
	private static HashMap jsonStringToHashMap(String str) throws Exception{
		HashMap dataMap = new HashMap();
		JSONParser parser = new JSONParser();
		try{
			Object obj = parser.parse(str);
			JSONObject jsonObject = (JSONObject)obj;

			Iterator<String> keyStr = jsonObject.keySet().iterator();
			while(keyStr.hasNext()){
				String key = keyStr.next();
				Object value = jsonObject.get(key);
				
				dataMap.put(key, value);
			}
		}catch(Exception e){
			
		}
		return dataMap;
	}

	
		
		
	

}
