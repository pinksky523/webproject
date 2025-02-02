package com.kjnresort.controller;




import java.security.Principal;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kjnresort.domain.Criteria;
import com.kjnresort.domain.MemberVO;
import com.kjnresort.domain.PageDTO;
import com.kjnresort.service.MemberService;
import com.kjnresort.service.ReviewService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/member/*")
@AllArgsConstructor
public class MemberController {
	private MemberService service;
	private ReviewService reviewService;
	
	
	
	//회원 상태수정(관리자)
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@PostMapping("statusModify")
	public String statusModify(MemberVO member, RedirectAttributes rttr, @ModelAttribute("cri") Criteria cri) {
		log.info("회원상태 수정 컨트롤러 진입");
		log.info("회원 상태값체크(컨트롤러) : " + member.getStatus());
		if(service.statusModify(member)) {
			if(member.getStatus() == 1) {
				rttr.addFlashAttribute("msg", "정지 상태로 변경되었습니다.");
			} else {
				rttr.addFlashAttribute("msg", "일반 상태로 변경되었습니다.");
			}
			
		}
		
		
		return "redirect:/member/list" + cri.getListlink();
	}
	
	
	
	
	//회원 상세조회(관리자)
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@GetMapping("get")
	public void getMember(String id, Model model, @ModelAttribute("cri") Criteria cri) {
		log.info("회원상세조회 창 진입(관리자)");
		log.info("get cri값 체크 : " + cri);
		model.addAttribute("member", service.getMember(id));
	}
	
	
	
	//회원 목록 창
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@GetMapping("list")
	public void memberList(Criteria cri, Model model) {
		log.info("회원목록 창 진입");
		log.info("cri 값 : " + cri);
		model.addAttribute("list", service.getMemberList(cri));
		
		int total = service.getTotalMember(cri);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
		
	}
	
	
	
	//내가 쓴 후기 버튼
	@PreAuthorize("isAuthenticated()")
	@PostMapping("myreview")
	public void myReviewList(@Param("id") String id, Criteria cri, Model model) {
		log.info("내가 쓴 후기 창 진입");
		int pageNum = cri.getPageNum();
		int amount = cri.getAmount();
		model.addAttribute("list", service.myreviewList(id, pageNum, amount));
		
		int total = service.getTotalMyReview(id, cri);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}
	
	//내가 쓴 후기 상세보기
	@GetMapping("myreviewGet")
	public void get(Long reviewNo, Model model, 
				    @ModelAttribute("cri") Criteria cri) {
		log.info("내가 쓴 후기 상세보기 창 진입");
		model.addAttribute("review", reviewService.get(reviewNo));
	}
		
		
	//마이페이지 회원탈퇴 버튼
	@PreAuthorize("isAuthenticated()")
	@PostMapping("remove")
	public String remove(MemberVO member, RedirectAttributes rttr, HttpSession session) {
		
		
		if(service.remove(member)) {
			rttr.addFlashAttribute("msg", "계정이 삭제되었습니다");
			
			return "/common/customLogout";
		} else {
			rttr.addFlashAttribute("msg", "계정 삭제 실패");
			return "redirect:/member/mypage?id=" + member.getId();
		}
		
	}

	//마이페이지 버튼
	@PreAuthorize("isAuthenticated()")
	@GetMapping("mypage")
	public void mypageGet(MemberVO member, Model model, Principal principal) {
		String userId = principal.getName();
		member.setId(userId);
		log.info("마이페이지 창 진입");
		log.info(member);
		model.addAttribute("member", service.mypageGet(member));
	}
	
	
	//마이페이지 수정버튼
	@PreAuthorize("isAuthenticated()")
	@PostMapping("mypageModify")
	public String mypagePost(MemberVO member, RedirectAttributes rttr) {
		String message;
		
		if(service.modifyMypage(member)) {
			message = "정보가 수정되었습니다.";
		} else {
			message = "정보 수정 실패";
		}
		
		rttr.addFlashAttribute("member", member);
		rttr.addFlashAttribute("msg", message);
		return "redirect:/member/mypage";
	}
}
