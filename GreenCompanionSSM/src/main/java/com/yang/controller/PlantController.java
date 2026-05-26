package com.yang.controller;

import com.yang.entity.Plant;
import com.yang.entity.User;
import com.yang.service.CollectService;
import com.yang.service.CommentService;
import com.yang.service.PlantService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/plant")
public class PlantController {

    @Autowired
    private PlantService plantService;

    @Autowired
    private CollectService collectService;

    @Autowired
    private CommentService commentService;

    @RequestMapping("/list")
    @ResponseBody
    public List<Plant> getAdoptPlantList() {
        return plantService.getAdoptPlants();
    }

    @RequestMapping("/toList")
    public String toPlantList(Model model) {
        List<Plant> plantList = plantService.getAdoptPlants();
        model.addAttribute("plantList", plantList);
        return "list";
    }

    @RequestMapping("/toAdd")
    public String toAddPage() {
        return "add";
    }

    @RequestMapping("/add")
    public String addPlant(Plant plant) {
        if (plant.getPlant_name() == null || plant.getPlant_name().trim().isEmpty()) {
            plant.setPlant_name("未命名绿植");
        }
        if (plant.getPlant_type() == null || plant.getPlant_type().trim().isEmpty()) {
            plant.setPlant_type("绿植");
        }
        if (plant.getPlant_img() == null || plant.getPlant_img().trim().isEmpty()) {
            plant.setPlant_img("https://picsum.photos/300/180");
        }
        plant.setCurrent_status("待领养");
        plantService.addPlant(plant);
        return "redirect:/plant/toList";
    }

    @RequestMapping("/delete")
    public String deletePlant(@RequestParam("id") Integer id) {
        plantService.deletePlant(id);
        return "redirect:/plant/toList";
    }

    // ====================== 🔥 这里修复了！======================
    @RequestMapping("/toBrowse")
    public String toBrowse(String keyword, Model model, HttpSession session) {
        List<Plant> plantList;
        if (keyword != null && !keyword.trim().isEmpty()) {
            plantList = plantService.getPlantsByNameLike("%" + keyword + "%");
        } else {
            plantList = plantService.getAdoptPlants();
        }
        model.addAttribute("plantList", plantList);

        User user = (User) session.getAttribute("loginUser");
        if (user != null) {
            model.addAttribute("collectList", collectService.getMyCollect(user.getUser_id()));
            model.addAttribute("loginUser", user); // 🔥 把用户传给页面！
        } else {
            model.addAttribute("collectList", null);
            model.addAttribute("loginUser", null); // 🔥 空值也要传！
        }
        return "plant_browse";
    }
    // ===========================================================

    @RequestMapping("/toEdit")
    public String toEditPage(@RequestParam("id") Integer id, Model model) {
        Plant plant = plantService.getPlantById(id);
        model.addAttribute("plant", plant);
        return "edit";
    }

    @RequestMapping("/edit")
    public String editPlant(Plant plant) {
        plantService.updatePlant(plant);
        return "redirect:/plant/toList";
    }
}