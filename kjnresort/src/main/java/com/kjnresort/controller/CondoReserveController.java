package com.kjnresort.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kjnresort.domain.CondoReserveVO;
import com.kjnresort.domain.Criteria;
import com.kjnresort.service.CondoReserveService;
import com.kjnresort.service.CondoReserveServiceImpl;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;


@Log4j
@RequestMapping("/condoreserve/*")
@AllArgsConstructor
@Controller
public class CondoReserveController { //헐 이제 될거같아
	private CondoReserveService service;
	
	//@DateTimeFormat(pattern="yyyy-MM-dd")
	//produces= {MediaType.TEXT_PLAIN_VALUE}
	//consumes = "application/json"
	@ResponseBody
	@RequestMapping(value="/availableRoomType",method = RequestMethod.POST,produces= {MediaType.APPLICATION_XML_VALUE,
			   MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<List<String>> getAvailableRoomTypeList(@Param("checkIn") @DateTimeFormat(pattern="yyyy-MM-dd") Date checkIn,@Param("checkOut") @DateTimeFormat(pattern="yyyy-MM-dd") Date checkOut) {
		log.info("getAvailableRoomTypeList Controller 진입");
		Calendar in=Calendar.getInstance();
		in.setTime(checkIn);
		Calendar out=Calendar.getInstance();
		out.setTime(checkOut);
	
		return new ResponseEntity<>(service.getAvailableRoomType(in, out),HttpStatus.OK);
	}
	@GetMapping("/list")
	public void list(Model model,Criteria cri,Principal principal) {
		
	}
	
	
	@GetMapping("/get")
	public CondoReserveVO get(Long rno,Model model,Criteria cri) {
		return null;
	}
	
	
	@PostMapping("/confirm")
	public void reserveConfirm(CondoReserveVO crvo,Model model,RedirectAttributes rttr,Criteria cri) {
		
	}
	
	
	@PostMapping("/cancel")
	public void reserveCancel(CondoReserveVO crvo,Model model,RedirectAttributes rttr,Criteria cri) {
		
	}
	
	@GetMapping("/register")
	public void register() {
		
	}
	@PostMapping("/register")
	public String register(CondoReserveVO crVO,RedirectAttributes rttr) {
		return null;
	}
	

	
}
