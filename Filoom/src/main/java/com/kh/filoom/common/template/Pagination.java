package com.kh.filoom.common.template;

import com.kh.filoom.common.model.vo.PageInfo;

public class Pagination {
	
	public static PageInfo getPageInfo(int listCount,
									   int currentPage,
									   int pageLimit,
									   int boardLimit) {
		
		int maxPage = (int)Math.ceil((double)listCount / boardLimit);
		int startPage = (currentPage - 1) / pageLimit * pageLimit + 1;
		int endPage = startPage + pageLimit - 1;
		
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		
		//rowNum 에 대입할 시작, 끝 수
		int startNum = (currentPage-1) * boardLimit;
		int endNum = currentPage * boardLimit;
		
		
		return new PageInfo(listCount, currentPage, pageLimit,
			boardLimit, maxPage, startPage, endPage,startNum, endNum);
	}

}
