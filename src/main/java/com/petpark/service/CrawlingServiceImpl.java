package com.petpark.service;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.petpark.dto.CrawlingDTO;
import com.petpark.mapper.CrawlingMapper;

@Service
public class CrawlingServiceImpl implements CrawlingService {
	
	@Autowired
	private CrawlingMapper crawlingMapper; // 크롤링한 데이터를 DB에 저장하기 위해 Mapper클래스 의존성 주입
	
	/* 산업, 정책, 사회, 문화, 동물복지, 수의계에 대한 뉴스 데이터 크롤링 */
	@Override
	public void newsCrawling() throws Exception { 

		CrawlingDTO crawlingDTO = new CrawlingDTO(); // 크롤링한 데이터를 넣을 DTO
		
		int industryPageCount = 0; // 산업 메뉴 페이지 시작번호
		int policyPageCount = 0; // 정책 메뉴 페이지 시작번호
		int societyPageCount = 0; // 사회 메뉴 페이지 시작번호
		int culturePageCount = 0; // 문화 메뉴 페이지 시작번호
		int welfarePageCount = 0; // 동물복지 메뉴 페이지 시작번호
		int veterinaryFieldPageCount = 0; // 수의계 메뉴 페이지 시작번호
		
		int count = 0; // 크롤링한 데이터가 DB에 있는지 count 로 구별하기 위함

		int i = 1;	
		
		/* 산업 메뉴 크롤링 */

		while(true) {
						
			industryPageCount++;
			
			// 크롤링할 링크 연결
			
			Document doc = Jsoup.connect("https://www.pet-news.or.kr/news/articleList.html?page=" + industryPageCount + "&box_idxno=&sc_section_code=S1N37&view_type=sm").get();
					
			/* 끝 페이지 가져오기 
			 * 
			 * 전체 페이지를 읽어야할 때 주석 풀고 사용
			 * 
			String industryPageCountString = industryPageCount + "";
			
			String endPage = "";			
			
			Elements liPageTags = doc.select("li.pagination-end");
			
			for(Element liPageTag : liPageTags) {
				
				Element aPageTag = liPageTag.selectFirst("a");
				
				String endPageHref = aPageTag.attr("href");
				
				int startIndex = endPageHref.indexOf("page=");
				
				int endIndex = endPageHref.indexOf("&");
				
				endPage = endPageHref.substring(startIndex,endIndex).replace("page=", "");
				
			}
					
			 */
			
			String url = "https://www.pet-news.or.kr"; // 홈페이지 주소 (나중에 a 태그 링크로 접속하기 위해 사용)
					
			Elements sectionTags = doc.select("section [id=section-list]"); // 뉴스 리스트 게시물을 감싸고 있는 section 태그 선택
			
			int result = 0; // 크롤링 결과값 확인 1이면 성공 0이면 실패	
			
			for (Element sectionTag : sectionTags) {
				
				crawlingDTO.setCategories("industry"); // industry(산업) 카테고리 저장
				
				Elements liTags = sectionTag.select("li:not([id=sample])");// li태그안에 있는 제목, 이미지URL, 날짜, 작성자 를 가져오기 위해 해당 li태그를 담음
				
				for (Element liTag : liTags) { // li 태그 요소를 하나씩 읽기
					
					/* title 데이터 클로링 */
					Elements divTags = liTag.select("div.view-cont"); // div 태그 안에 있는 h4태그의 제목을 가져오기 위해 div 태그 가져오기
					
					for (Element divTag : divTags) { // 가져온 div 태그 읽기
						
						Element h4Tag = divTag.selectFirst("h4.titles");
						
						crawlingDTO.setSubject(h4Tag.text()); // dto에 정보 저장
						
					}
					
					/* imageURL 데이터 클로링 */
					Elements aTags = liTag.select("a.thumb"); // a 태그 안에 있는 이미지를 가져오기 위해 a 태그 데이터 가져오기(선택)
					
					for (Element aTag : aTags) { // a 태그안에 이미지 URL 추출하기 위한 for문
						
						Element imageTag = aTag.selectFirst("img"); // a 태그안에 있는 첫번째 img 태그 선택
						
						if (imageTag != null) {
							
							if (!imageTag.attr("src").equals("")) { // 해당 페이지에 마지막에 공백이 있는 src가 있어서 제외시킴
								
								String image = imageTag.attr("src");
								
								crawlingDTO.setMain_image(image);
								
							}
						}
					}
					
					/* writer(글쓴이), date(글작성 날짜) 크롤링 */
					Elements spanElements = liTag.select("span.byline"); // span태그 안에 있는 em태그의 기자 이름과 날짜를 크롤링 하기위해 해당 span요소를 선택
					
					for (Element spanElement : spanElements) { // span 요소 뽑기
						
						Elements emTags = spanElement.select("em"); // span 태그 안에 있는 em 태그 데이터를 저장
						
						for (Element emTag : emTags) { // em태그의 정보들을 한 개씩 추출하여 기자와 날짜에 대한 데이터를 추출하기 위한 for문
							
							String em = emTag.text().trim(); // em 데이터를 태그 없이 text 데이터만 저장
							
							if (em.contains("기자")) {
								
								crawlingDTO.setWriter(em);
																
							} else if (em.contains(":")) {
								
								crawlingDTO.setDate(em);
								
							}
						}
					}
					
					/* 각 리스트의 링크로 들어가 내용 크롤링 */
					for (Element divTag : divTags) { // 가져온 div 태그 읽기
						
						Elements h4Tags = divTag.select("h4.titles");
						
						for (Element h4Tag : h4Tags) {
							
							Elements links = h4Tag.select("a[href]");
							
							for (Element link : links) {
								
								String hrefLink = url + link.attr("href"); // 링크 주소 = url변수와 합쳐서 경로 완성 목적
								
								Document docLink = Jsoup.connect(hrefLink).get();
								
								Elements contents = docLink.select("article [id=article-view-content-div]"); // 내용을 전부 포함하고 있는 태그 선택
								
								for (Element content : contents) {
									
									String contentText = content.outerHtml();
									
									if (!contentText.equals("")) {
										
										crawlingDTO.setContent(contentText);
										
									}
								}
							}
						}
					}
					
					// DB에 데이터 넣기			
					
					count = crawlingMapper.newsCount(crawlingDTO.getSubject()); // 해당 subject의 count 수를 담음
					
					if(count == 0) { // count가 0이라면 데이터가 없다는 의미로 크롤링 데이터를 저장			
						
						result = crawlingMapper.newsCrawling(crawlingDTO);		
						
						System.out.println(i++ + "번째 크롤링 결과 ( 산업 ) : " + result + " ( 0이면 실패 1이면 성공 )");			
						
					} 					
				}				
			}	
			
			/* 전체 페이지 크롤링할 떄 break문
			if(endPage.equals(industryPageCountString)) {
				break;
			}
			*/
			
			break;
			
		}
				
		
		/* 정책 메뉴 크롤링 */
		
		count = 0; // while문 반복을 위해 count에 0 저장
		
		while(true) {
										
			policyPageCount++;
			
			// 크롤링할 링크 연결
			
			Document doc = Jsoup.connect("https://www.pet-news.or.kr/news/articleList.html?page=" + policyPageCount + "&box_idxno=&sc_section_code=S1N38&view_type=sm").get();
						
			/* 끝 페이지 가져오기 
			 * 
			 * 전체 페이지를 읽어야할 때 주석 풀고 사용
			 * 
			String policyPageCountString = policyPageCount + "";
			
			String endPage = "";
			
			Elements liPageTags = doc.select("li.pagination-end");
			
			for(Element liPageTag : liPageTags) {
				
				Element aPageTag = liPageTag.selectFirst("a");
				
				String endPageHref = aPageTag.attr("href");
				
				int startIndex = endPageHref.indexOf("page=");
				
				int endIndex = endPageHref.indexOf("&");
				
				endPage = endPageHref.substring(startIndex,endIndex).replace("page=", "");
				
			}
			
			*/
			
			String url = "https://www.pet-news.or.kr"; // 홈페이지 주소 (나중에 a 태그 링크로 접속하기 위해 사용)
			
			Elements sectionTags = doc.select("section [id=section-list]"); // 뉴스 리스트 게시물을 감싸고 있는 section 태그 선택
			
			int result = 0; // 크롤링 결과값 확인 1이면 성공 0이면 실패			
			
			for (Element sectionTag : sectionTags) {
				
				crawlingDTO.setCategories("policy"); // industry(산업) 카테고리 저장
				
				Elements liTags = sectionTag.select("li:not([id=sample])");// li태그안에 있는 제목, 이미지URL, 날짜, 작성자 를 가져오기 위해 해당 li태그를 담음
				
				for (Element liTag : liTags) { // li 태그 요소를 하나씩 읽기
					
					/* title 데이터 클로링 */
					Elements divTags = liTag.select("div.view-cont"); // div 태그 안에 있는 h4태그의 제목을 가져오기 위해 div 태그 가져오기
					
					for (Element divTag : divTags) { // 가져온 div 태그 읽기
						
						Element h4Tag = divTag.selectFirst("h4.titles");
						
						crawlingDTO.setSubject(h4Tag.text()); // dto에 정보 저장
						
					}
					
					/* imageURL 데이터 클로링 */
					Elements aTags = liTag.select("a.thumb"); // a 태그 안에 있는 이미지를 가져오기 위해 a 태그 데이터 가져오기(선택)
					
					for (Element aTag : aTags) { // a 태그안에 이미지 URL 추출하기 위한 for문
						
						Element imageTag = aTag.selectFirst("img"); // a 태그안에 있는 첫번째 img 태그 선택
						
						if (imageTag != null) {
							
							if (!imageTag.attr("src").equals("")) { // 해당 페이지에 마지막에 공백이 있는 src가 있어서 제외시킴
								
								String image = imageTag.attr("src");
								
								crawlingDTO.setMain_image(image);
								
							}
						}
					}
					
					/* writer(글쓴이), date(글작성 날짜) 크롤링 */
					Elements spanElements = liTag.select("span.byline"); // span태그 안에 있는 em태그의 기자 이름과 날짜를 크롤링 하기위해 해당 span요소를 선택
					
					for (Element spanElement : spanElements) { // span 요소 뽑기
						
						Elements emTags = spanElement.select("em"); // span 태그 안에 있는 em 태그 데이터를 저장
						
						for (Element emTag : emTags) { // em태그의 정보들을 한 개씩 추출하여 기자와 날짜에 대한 데이터를 추출하기 위한 for문
							
							String em = emTag.text().trim(); // em 데이터를 태그 없이 text 데이터만 저장
							
							if (em.contains("기자")) {
								
								crawlingDTO.setWriter(em);
								
								
							} else if (em.contains(":")) {
								
								crawlingDTO.setDate(em);
								
							}
						}
					}
					
					/* 각 리스트의 링크로 들어가 내용 크롤링 */
					for (Element divTag : divTags) { // 가져온 div 태그 읽기
						
						Elements h4Tags = divTag.select("h4.titles");
						
						for (Element h4Tag : h4Tags) {
							
							Elements links = h4Tag.select("a[href]");
							
							for (Element link : links) {
								
								String hrefLink = url + link.attr("href"); // 링크 주소 = url변수와 합쳐서 경로 완성 목적
								
								Document docLink = Jsoup.connect(hrefLink).get();
								
								Elements contents = docLink.select("article [id=article-view-content-div]"); // 내용을 전부 포함하고 있는 태그 선택
								
								for (Element content : contents) {
									
									String contentText = content.outerHtml();
									
									if (!contentText.equals("")) {
										
										crawlingDTO.setContent(contentText);
										
									}
								}
							}
						}
					}
					
					// DB에 데이터 넣기			
					
					count = crawlingMapper.newsCount(crawlingDTO.getSubject()); // 해당 subject의 count 수를 담음
					
					if(count == 0) { // count가 0이라면 데이터가 없다는 의미로 크롤링 데이터를 저장			
						
						result = crawlingMapper.newsCrawling(crawlingDTO);		
						
						System.out.println(i++ + "번째 크롤링 결과 ( 정책 ) : " + result + " ( 0이면 실패 1이면 성공 )");			
						
					} 					
				}
			}
			
			/*
			if(endPage.equals(policyPageCountString)) {
				break;
			}
			*/
			
			break;
			
		}
				
		/* 사회 메뉴 크롤링 */
		
		count = 0;
		
		while(true) {
			
			societyPageCount++;
						
			// 크롤링할 링크 연결
			Document doc = Jsoup.connect("https://www.pet-news.or.kr/news/articleList.html?page=" + societyPageCount + "&box_idxno=&sc_section_code=S1N39&view_type=sm").get();
							
			/* 끝 페이지 가져오기 
			 * 
			 * 전체 페이지를 읽어야할 때 주석 풀고 사용
			 * 
			String societyPageCounttString = societyPageCount + "";
			
			String endPage = "";
			
			Elements liPageTags = doc.select("li.pagination-end");
			
			for(Element liPageTag : liPageTags) {
				
				Element aPageTag = liPageTag.selectFirst("a");
				
				String endPageHref = aPageTag.attr("href");
				
				int startIndex = endPageHref.indexOf("page=");
				
				int endIndex = endPageHref.indexOf("&");
				
				endPage = endPageHref.substring(startIndex,endIndex).replace("page=", "");
				
			}
			
			 */
			
			String url = "https://www.pet-news.or.kr"; // 홈페이지 주소 (나중에 a 태그 링크로 접속하기 위해 사용)
			
			Elements sectionTags = doc.select("section [id=section-list]"); // 뉴스 리스트 게시물을 감싸고 있는 section 태그 선택
			
			int result = 0; // 크롤링 결과값 확인 1이면 성공 0이면 실패			
			
			for (Element sectionTag : sectionTags) {
				
				crawlingDTO.setCategories("society"); // industry(산업) 카테고리 저장
				
				Elements liTags = sectionTag.select("li:not([id=sample])");// li태그안에 있는 제목, 이미지URL, 날짜, 작성자 를 가져오기 위해 해당 li태그를 담음
				
				for (Element liTag : liTags) { // li 태그 요소를 하나씩 읽기
					
					/* title 데이터 클로링 */
					Elements divTags = liTag.select("div.view-cont"); // div 태그 안에 있는 h4태그의 제목을 가져오기 위해 div 태그 가져오기
					
					for (Element divTag : divTags) { // 가져온 div 태그 읽기
						
						Element h4Tag = divTag.selectFirst("h4.titles");
						
						crawlingDTO.setSubject(h4Tag.text()); // dto에 정보 저장
						
					}
					
					/* imageURL 데이터 클로링 */
					Elements aTags = liTag.select("a.thumb"); // a 태그 안에 있는 이미지를 가져오기 위해 a 태그 데이터 가져오기(선택)
					
					for (Element aTag : aTags) { // a 태그안에 이미지 URL 추출하기 위한 for문
						
						Element imageTag = aTag.selectFirst("img"); // a 태그안에 있는 첫번째 img 태그 선택
						
						if (imageTag != null) {
							
							if (!imageTag.attr("src").equals("")) { // 해당 페이지에 마지막에 공백이 있는 src가 있어서 제외시킴
								
								String image = imageTag.attr("src");
								
								crawlingDTO.setMain_image(image);
								
							}
						}
					}
					
					/* writer(글쓴이), date(글작성 날짜) 크롤링 */
					Elements spanElements = liTag.select("span.byline"); // span태그 안에 있는 em태그의 기자 이름과 날짜를 크롤링 하기위해 해당 span요소를 선택
					
					for (Element spanElement : spanElements) { // span 요소 뽑기
						
						Elements emTags = spanElement.select("em"); // span 태그 안에 있는 em 태그 데이터를 저장
						
						for (Element emTag : emTags) { // em태그의 정보들을 한 개씩 추출하여 기자와 날짜에 대한 데이터를 추출하기 위한 for문
							
							String em = emTag.text().trim(); // em 데이터를 태그 없이 text 데이터만 저장
							
							if (em.contains("기자")) {
								
								crawlingDTO.setWriter(em);
								
								
							} else if (em.contains(":")) {
								
								crawlingDTO.setDate(em);
								
							}
						}
					}
					
					/* 각 리스트의 링크로 들어가 내용 크롤링 */
					for (Element divTag : divTags) { // 가져온 div 태그 읽기
						
						Elements h4Tags = divTag.select("h4.titles");
						
						for (Element h4Tag : h4Tags) {
							
							Elements links = h4Tag.select("a[href]");
							
							for (Element link : links) {
								
								String hrefLink = url + link.attr("href"); // 링크 주소 = url변수와 합쳐서 경로 완성 목적
								
								Document docLink = Jsoup.connect(hrefLink).get();
								
								Elements contents = docLink.select("article [id=article-view-content-div]"); // 내용을 전부 포함하고 있는 태그 선택
								
								for (Element content : contents) {
									
									String contentText = content.outerHtml();
									
									if (!contentText.equals("")) {
										
										crawlingDTO.setContent(contentText);
										
									}
								}
							}
						}
					}
					
					// DB에 데이터 넣기			
					
					count = crawlingMapper.newsCount(crawlingDTO.getSubject()); // 해당 subject의 count 수를 담음
					
					if(count == 0) { // count가 0이라면 데이터가 없다는 의미로 크롤링 데이터를 저장			
						
						result = crawlingMapper.newsCrawling(crawlingDTO);		
						
						System.out.println(i++ + "번째 크롤링 결과 ( 사회 ) : " + result + " ( 0이면 실패 1이면 성공 )");			
						
					}
				}
			}
			
			/*
			if(endPage.equals(societyPageCounttString)) {
				break;
			}
			*/
			
			break;
			
		}
		
		/* 문화 메뉴 크롤링 */
		
		count = 0;
		
		while(true) {
			
			culturePageCount++;
						
			// 크롤링할 링크 연결
			Document doc = Jsoup.connect("https://www.pet-news.or.kr/news/articleList.html?page=" + culturePageCount + "&box_idxno=&sc_section_code=S1N40&view_type=sm").get();
					
			
			/* 끝 페이지 가져오기 
			 * 
			 * 전체 페이지를 읽어야할 때 주석 풀고 사용
			 * 			
			String culturePageCountString = culturePageCount + "";
			
			String endPage = "";
			
			Elements liPageTags = doc.select("li.pagination-end");
			
			for(Element liPageTag : liPageTags) {
				
				Element aPageTag = liPageTag.selectFirst("a");
				
				String endPageHref = aPageTag.attr("href");
				
				int startIndex = endPageHref.indexOf("page=");
				
				int endIndex = endPageHref.indexOf("&");
				
				endPage = endPageHref.substring(startIndex,endIndex).replace("page=", "");
				
			}
			
			*/
			
			String url = "https://www.pet-news.or.kr"; // 홈페이지 주소 (나중에 a 태그 링크로 접속하기 위해 사용)
			
			Elements sectionTags = doc.select("section [id=section-list]"); // 뉴스 리스트 게시물을 감싸고 있는 section 태그 선택
			
			int result = 0; // 크롤링 결과값 확인 1이면 성공 0이면 실패		
			
			for (Element sectionTag : sectionTags) {
				
				crawlingDTO.setCategories("culture"); // industry(산업) 카테고리 저장
				
				Elements liTags = sectionTag.select("li:not([id=sample])");// li태그안에 있는 제목, 이미지URL, 날짜, 작성자 를 가져오기 위해 해당 li태그를 담음
				
				for (Element liTag : liTags) { // li 태그 요소를 하나씩 읽기
					
					/* title 데이터 클로링 */
					Elements divTags = liTag.select("div.view-cont"); // div 태그 안에 있는 h4태그의 제목을 가져오기 위해 div 태그 가져오기
					
					for (Element divTag : divTags) { // 가져온 div 태그 읽기
						
						Element h4Tag = divTag.selectFirst("h4.titles");
						
						crawlingDTO.setSubject(h4Tag.text()); // dto에 정보 저장
						
					}
					
					/* imageURL 데이터 클로링 */
					Elements aTags = liTag.select("a.thumb"); // a 태그 안에 있는 이미지를 가져오기 위해 a 태그 데이터 가져오기(선택)
					
					for (Element aTag : aTags) { // a 태그안에 이미지 URL 추출하기 위한 for문
						
						Element imageTag = aTag.selectFirst("img"); // a 태그안에 있는 첫번째 img 태그 선택
						
						if (imageTag != null) {
							
							if (!imageTag.attr("src").equals("")) { // 해당 페이지에 마지막에 공백이 있는 src가 있어서 제외시킴
								
								String image = imageTag.attr("src");
								
								crawlingDTO.setMain_image(image);
								
							}
						}
					}
					
					/* writer(글쓴이), date(글작성 날짜) 크롤링 */
					Elements spanElements = liTag.select("span.byline"); // span태그 안에 있는 em태그의 기자 이름과 날짜를 크롤링 하기위해 해당 span요소를 선택
					
					for (Element spanElement : spanElements) { // span 요소 뽑기
						
						Elements emTags = spanElement.select("em"); // span 태그 안에 있는 em 태그 데이터를 저장
						
						for (Element emTag : emTags) { // em태그의 정보들을 한 개씩 추출하여 기자와 날짜에 대한 데이터를 추출하기 위한 for문
							
							String em = emTag.text().trim(); // em 데이터를 태그 없이 text 데이터만 저장
							
							if (em.contains("기자")) {
								
								crawlingDTO.setWriter(em);
								
								
							} else if (em.contains(":")) {
								
								crawlingDTO.setDate(em);
								
							}
						}
					}
					
					/* 각 리스트의 링크로 들어가 내용 크롤링 */
					for (Element divTag : divTags) { // 가져온 div 태그 읽기
						
						Elements h4Tags = divTag.select("h4.titles");
						
						for (Element h4Tag : h4Tags) {
							
							Elements links = h4Tag.select("a[href]");
							
							for (Element link : links) {
								
								String hrefLink = url + link.attr("href"); // 링크 주소 = url변수와 합쳐서 경로 완성 목적
								
								Document docLink = Jsoup.connect(hrefLink).get();
								
								Elements contents = docLink.select("article [id=article-view-content-div]"); // 내용을 전부 포함하고 있는 태그 선택
								
								for (Element content : contents) {
									
									String contentText = content.outerHtml();
									
									if (!contentText.equals("")) {
										
										crawlingDTO.setContent(contentText);
										
									}
								}
							}
						}
					}
					
					// DB에 데이터 넣기			
					
					count = crawlingMapper.newsCount(crawlingDTO.getSubject()); // 해당 subject의 count 수를 담음
					
					if(count == 0) { // count가 0이라면 데이터가 없다는 의미로 크롤링 데이터를 저장			
						
						result = crawlingMapper.newsCrawling(crawlingDTO);		
						
						System.out.println(i++ + "번째 크롤링 결과 ( 문화 ) : " + result + " ( 0이면 실패 1이면 성공 )");			
						
					}								
				}
			}
			
			/*
			if(endPage.equals(culturePageCountString)) {
				break;
			}
			*/
			
			break;
			
		}
			
		/* 동물복지 메뉴 크롤링 */
		
		count = 0;
		
		while(true) {
			
			welfarePageCount++;
						
			// 크롤링할 링크 연결
			Document doc = Jsoup.connect("https://www.pet-news.or.kr/news/articleList.html?page=" + welfarePageCount + "&box_idxno=&sc_section_code=S1N45&view_type=sm").get();
					
			
			/* 끝 페이지 가져오기 
			 * 
			 * 전체 페이지를 읽어야할 때 주석 풀고 사용
			 * 
			String welfarePageCountString = welfarePageCount + "";
			
			String endPage = "";
			
			Elements liPageTags = doc.select("li.pagination-end");
			
			for(Element liPageTag : liPageTags) {
				
				Element aPageTag = liPageTag.selectFirst("a");
				
				String endPageHref = aPageTag.attr("href");
				
				int startIndex = endPageHref.indexOf("page=");
				
				int endIndex = endPageHref.indexOf("&");
				
				endPage = endPageHref.substring(startIndex,endIndex).replace("page=", "");
				
			}
			
			*/
			
			String url = "https://www.pet-news.or.kr"; // 홈페이지 주소 (나중에 a 태그 링크로 접속하기 위해 사용)
			
			Elements sectionTags = doc.select("section [id=section-list]"); // 뉴스 리스트 게시물을 감싸고 있는 section 태그 선택
			
			int result = 0; // 크롤링 결과값 확인 1이면 성공 0이면 실패
						
			for (Element sectionTag : sectionTags) {
				
				crawlingDTO.setCategories("welfare"); // industry(산업) 카테고리 저장
				
				Elements liTags = sectionTag.select("li:not([id=sample])");// li태그안에 있는 제목, 이미지URL, 날짜, 작성자 를 가져오기 위해 해당 li태그를 담음
				
				for (Element liTag : liTags) { // li 태그 요소를 하나씩 읽기
					
					/* title 데이터 클로링 */
					Elements divTags = liTag.select("div.view-cont"); // div 태그 안에 있는 h4태그의 제목을 가져오기 위해 div 태그 가져오기
					
					for (Element divTag : divTags) { // 가져온 div 태그 읽기
						
						Element h4Tag = divTag.selectFirst("h4.titles");
						
						crawlingDTO.setSubject(h4Tag.text()); // dto에 정보 저장
						
					}
					
					/* imageURL 데이터 클로링 */
					Elements aTags = liTag.select("a.thumb"); // a 태그 안에 있는 이미지를 가져오기 위해 a 태그 데이터 가져오기(선택)
					
					for (Element aTag : aTags) { // a 태그안에 이미지 URL 추출하기 위한 for문
						
						Element imageTag = aTag.selectFirst("img"); // a 태그안에 있는 첫번째 img 태그 선택
						
						if (imageTag != null) {
							
							if (!imageTag.attr("src").equals("")) { // 해당 페이지에 마지막에 공백이 있는 src가 있어서 제외시킴
								
								String image = imageTag.attr("src");
								
								crawlingDTO.setMain_image(image);
								
							}
						}
					}
					
					/* writer(글쓴이), date(글작성 날짜) 크롤링 */
					Elements spanElements = liTag.select("span.byline"); // span태그 안에 있는 em태그의 기자 이름과 날짜를 크롤링 하기위해 해당 span요소를 선택
					
					for (Element spanElement : spanElements) { // span 요소 뽑기
						
						Elements emTags = spanElement.select("em"); // span 태그 안에 있는 em 태그 데이터를 저장
						
						for (Element emTag : emTags) { // em태그의 정보들을 한 개씩 추출하여 기자와 날짜에 대한 데이터를 추출하기 위한 for문
							
							String em = emTag.text().trim(); // em 데이터를 태그 없이 text 데이터만 저장
							
							if (em.contains("기자")) {
								
								crawlingDTO.setWriter(em);
								
								
							} else if (em.contains(":")) {
								
								crawlingDTO.setDate(em);
								
							}
						}
					}
					
					/* 각 리스트의 링크로 들어가 내용 크롤링 */
					for (Element divTag : divTags) { // 가져온 div 태그 읽기
						
						Elements h4Tags = divTag.select("h4.titles");
						
						for (Element h4Tag : h4Tags) {
							
							Elements links = h4Tag.select("a[href]");
							
							for (Element link : links) {
								
								String hrefLink = url + link.attr("href"); // 링크 주소 = url변수와 합쳐서 경로 완성 목적
								
								Document docLink = Jsoup.connect(hrefLink).get();
								
								Elements contents = docLink.select("article [id=article-view-content-div]"); // 내용을 전부 포함하고 있는 태그 선택
								
								for (Element content : contents) {
									
									String contentText = content.outerHtml();
									
									if (!contentText.equals("")) {
										
										crawlingDTO.setContent(contentText);
										
									}
								}
							}
						}
					}
					
					// DB에 데이터 넣기			
					
					count = crawlingMapper.newsCount(crawlingDTO.getSubject()); // 해당 subject의 count 수를 담음
					
					if(count == 0) { // count가 0이라면 데이터가 없다는 의미로 크롤링 데이터를 저장			
						
						result = crawlingMapper.newsCrawling(crawlingDTO);		
						
						System.out.println(i++ + "번째 크롤링 결과 ( 동물복지 ) : " + result + " ( 0이면 실패 1이면 성공 )");			
						
					}					
				}
			}
			
			/*
			if(endPage.equals(welfarePageCountString)) {
				break;
			}
			*/
			
			break;
			
		}
				
		/* 수의계 메뉴 크롤링 */
		
		count = 0;
		
		while(true) {
			
			veterinaryFieldPageCount++;
						
			// 크롤링할 링크 연결
			Document doc = Jsoup.connect("https://www.pet-news.or.kr/news/articleList.html?page=" + veterinaryFieldPageCount + "&box_idxno=&sc_section_code=S1N46&view_type=sm").get();
								
			/* 끝 페이지 가져오기 
			 * 
			 * 전체 페이지를 읽어야할 때 주석 풀고 사용
			 * 
			String veterinaryFieldPageCountString = veterinaryFieldPageCount + "";
			
			String endPage = "";
			
			Elements liPageTags = doc.select("li.pagination-end");
			
			for(Element liPageTag : liPageTags) {
				
				Element aPageTag = liPageTag.selectFirst("a");
				
				String endPageHref = aPageTag.attr("href");
				
				int startIndex = endPageHref.indexOf("page=");
				
				int endIndex = endPageHref.indexOf("&");
				
				endPage = endPageHref.substring(startIndex,endIndex).replace("page=", "");
				
			}
			
			*/
			
			String url = "https://www.pet-news.or.kr"; // 홈페이지 주소 (나중에 a 태그 링크로 접속하기 위해 사용)
			
			Elements sectionTags = doc.select("section [id=section-list]"); // 뉴스 리스트 게시물을 감싸고 있는 section 태그 선택
			
			int result = 0; // 크롤링 결과값 확인 1이면 성공 0이면 실패
			
			for (Element sectionTag : sectionTags) {
				
				crawlingDTO.setCategories("veterinary_field"); // industry(산업) 카테고리 저장
				
				Elements liTags = sectionTag.select("li:not([id=sample])");// li태그안에 있는 제목, 이미지URL, 날짜, 작성자 를 가져오기 위해 해당 li태그를 담음
				
				for (Element liTag : liTags) { // li 태그 요소를 하나씩 읽기
					
					/* title 데이터 클로링 */
					Elements divTags = liTag.select("div.view-cont"); // div 태그 안에 있는 h4태그의 제목을 가져오기 위해 div 태그 가져오기
					
					for (Element divTag : divTags) { // 가져온 div 태그 읽기
						
						Element h4Tag = divTag.selectFirst("h4.titles");
						
						crawlingDTO.setSubject(h4Tag.text()); // dto에 정보 저장
						
					}
					
					/* imageURL 데이터 클로링 */
					Elements aTags = liTag.select("a.thumb"); // a 태그 안에 있는 이미지를 가져오기 위해 a 태그 데이터 가져오기(선택)
					
					for (Element aTag : aTags) { // a 태그안에 이미지 URL 추출하기 위한 for문
						
						Element imageTag = aTag.selectFirst("img"); // a 태그안에 있는 첫번째 img 태그 선택
						
						if (imageTag != null) {
							
							if (!imageTag.attr("src").equals("")) { // 해당 페이지에 마지막에 공백이 있는 src가 있어서 제외시킴
								
								String image = imageTag.attr("src");
								
								crawlingDTO.setMain_image(image);
								
							}
						}
					}
					
					/* writer(글쓴이), date(글작성 날짜) 크롤링 */
					Elements spanElements = liTag.select("span.byline"); // span태그 안에 있는 em태그의 기자 이름과 날짜를 크롤링 하기위해 해당 span요소를 선택
					
					for (Element spanElement : spanElements) { // span 요소 뽑기
						
						Elements emTags = spanElement.select("em"); // span 태그 안에 있는 em 태그 데이터를 저장
						
						for (Element emTag : emTags) { // em태그의 정보들을 한 개씩 추출하여 기자와 날짜에 대한 데이터를 추출하기 위한 for문
							
							String em = emTag.text().trim(); // em 데이터를 태그 없이 text 데이터만 저장
							
							if (em.contains("기자")) {
								
								crawlingDTO.setWriter(em);
								
								
							} else if (em.contains(":")) {
								
								crawlingDTO.setDate(em);
								
							}
						}
					}
					
					/* 각 리스트의 링크로 들어가 내용 크롤링 */
					for (Element divTag : divTags) { // 가져온 div 태그 읽기
						
						Elements h4Tags = divTag.select("h4.titles");
						
						for (Element h4Tag : h4Tags) {
							
							Elements links = h4Tag.select("a[href]");
							
							for (Element link : links) {
								
								String hrefLink = url + link.attr("href"); // 링크 주소 = url변수와 합쳐서 경로 완성 목적
								
								Document docLink = Jsoup.connect(hrefLink).get();
								
								Elements contents = docLink.select("article [id=article-view-content-div]"); // 내용을 전부 포함하고 있는 태그 선택
								
								for (Element content : contents) {
									
									String contentText = content.outerHtml();
									
									if (!contentText.equals("")) {
										
										crawlingDTO.setContent(contentText);
										
									}
								}
							}
						}
					}
					
					// DB에 데이터 넣기			
					
					count = crawlingMapper.newsCount(crawlingDTO.getSubject()); // 해당 subject의 count 수를 담음
					
					if(count == 0) { // count가 0이라면 데이터가 없다는 의미로 크롤링 데이터를 저장			
						
						result = crawlingMapper.newsCrawling(crawlingDTO);		
						
						System.out.println(i++ + "번째 크롤링 결과 ( 수의계 ) : " + result + " ( 0이면 실패 1이면 성공 )");			
						
					}
				}
			}
			
			/*
			if(endPage.equals(veterinaryFieldPageCountString)) {
				break;
			}
			*/
			
			break;
			
		}
	}
}
