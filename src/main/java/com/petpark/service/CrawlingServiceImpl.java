package com.petpark.service;

import java.util.ArrayList;

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

	// 산업 뉴스 리스트 메서드
	@Override
	public int industryList() throws Exception {

		CrawlingDTO crawlingDTO = new CrawlingDTO(); // 크롤링한 데이터를 넣을 DTO
		
		// 크롤링할 링크 연결
		Document doc = Jsoup.connect("https://www.pet-news.or.kr/news/articleList.html?page=1&total=545&box_idxno=&sc_section_code=S1N37&view_type=sm").get();
		
		String url = "https://www.pet-news.or.kr"; // 홈페이지 주소 (나중에 a 태그 링크로 접속하기 위해 사용)
		
		Elements sectionTags = doc.select("section [id=section-list]"); // 뉴스 리스트 게시물을 감싸고 있는 section 태그 선택
		
		int i = 1;
		
		for (Element sectionTag : sectionTags) {

			Elements liTags = sectionTag.select("li:not([id=sample])");// li태그안에 있는 제목, 이미지URL, 날짜, 작성자 를 가져오기 위해 해당 li태그를 담음
																	
			for (Element liTag : liTags) { // li 태그 요소를 하나씩 읽기

				/* title 데이터 클로링 */
				Elements divTags = liTag.select("div.view-cont"); // div 태그 안에 있는 h4태그의 제목을 가져오기 위해 div 태그 가져오기

				for (Element divTag : divTags) { // 가져온 div 태그 읽기

					Element h4Tag = divTag.selectFirst("h4.titles");

					crawlingDTO.setSubject(h4Tag.text()); // dto에 정보 저장

					System.out.println("CrawlingSubject : " + h4Tag.text());

				}

				/* imageURL 데이터 클로링 */
				Elements aTags = liTag.select("a.thumb"); // a 태그 안에 있는 이미지를 가져오기 위해 a 태그 데이터 가져오기(선택)

				for (Element aTag : aTags) { // a 태그안에 이미지 URL 추출하기 위한 for문

					Element imageTag = aTag.selectFirst("img"); // a 태그안에 있는 첫번째 img 태그 선택

					if (imageTag != null) {

						if (!imageTag.attr("src").equals("")) { // 해당 페이지에 마지막에 공백이 있는 src가 있어서 제외시킴

							String image = imageTag.attr("src");

							crawlingDTO.setMain_image(image);

							System.out.println("CrawlingImageURL : " + image);

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

							System.out.println("CrawlingWriter : " + em);

						} else if (em.contains(":")) {

							crawlingDTO.setDate(em);

							System.out.println("CrawlingDate : " + em);

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
//				int result = crawlingMapper.industryList(crawlingDTO);
//				
//				System.out.println(i++ + "번째 크롤링 결과 : " + result + " ( 0이면 실패 1이면 성공 )");

			}
		}
		
		return 0;
	}

	// 정책 뉴스 리스트 메서드
	@Override
	public ArrayList<CrawlingDTO> policyList() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	// 사회 뉴스 리스트 메서드
	@Override
	public ArrayList<CrawlingDTO> societyList() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	// 문화 뉴스 리스트 메서드
	@Override
	public ArrayList<CrawlingDTO> cultureList() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	// 동물복지 뉴스 리스트 메서드
	@Override
	public ArrayList<CrawlingDTO> welfareList() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	// 수의계 뉴스 리스트 메서드
	@Override
	public ArrayList<CrawlingDTO> veterinary_fieldList() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	
	// 크롤링 데이터 가져오기
	@Override
	public ArrayList<CrawlingDTO> selectNews() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

}
