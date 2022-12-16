package kr.or.ddit.autumn.groupware.resource.controller;

import java.io.IOException;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.autumn.groupware.resource.service.ResourceService;
import kr.or.ddit.autumn.vo.AttatchVO;

@Controller
public class ResourceImageController {

		@Inject
		private ResourceService service;
		
		@RequestMapping("/groupware/resource/resourceImageView.do")
		public String download(@RequestParam(required=true, name="what") int meetNo, Model model) throws IOException {
			
			AttatchVO imageInfoVO = service.retrieveResourceImage(meetNo);
			
			model.addAttribute("attatch", imageInfoVO);
			
			return "ImageView";
			
		}
		
}
