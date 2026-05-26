package com.yang.controller;

import com.yang.entity.AdoptApply;
import com.yang.entity.Plant;
import com.yang.entity.User;
import com.yang.service.AdoptApplyService;
import com.yang.service.PlantService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/idlePlant")
public class IdlePlantController {

    @Autowired
    private PlantService plantService;
    @Autowired
    private AdoptApplyService adoptApplyService;

    @RequestMapping("/toList")
    public String toList(Model model) {
        model.addAttribute("idleList", plantService.getAllPlants());
        return "idle_plant_list";
    }

    @RequestMapping("/toPublish")
    public String toPublish() {
        return "idle_plant_publish";
    }

    @RequestMapping("/publish")
    @ResponseBody
    public Map<String, Object> publish(
            @RequestParam String plant_name,
            @RequestParam String plant_type,
            @RequestParam(required = false) String plant_img,
            @RequestParam String description,
            HttpSession session) {
        Map<String, Object> map = new HashMap<>();
        User user = (User) session.getAttribute("loginUser");
        if (user == null) {
            map.put("code", 500);
            map.put("msg", "请先登录");
            return map;
        }
        Plant p = new Plant();
        p.setPlant_name(plant_name);
        p.setPlant_type(plant_type);
        p.setPlant_img(plant_img);
        p.setPlant_desc(description);
        p.setCurrent_status("待交换");
        plantService.addPlant(p);
        map.put("code", 200);
        map.put("msg", "发布成功");
        return map;
    }

    @RequestMapping("/toMyList")
    public String toMyList(Model model, HttpSession session) {
        model.addAttribute("myIdleList", plantService.getAllPlants());
        return "idle_plant_my";
    }

    @RequestMapping("/toExchangeApply")
    public String toExchangeApply(@RequestParam("idleId") Integer idleId, Model model) {
        Plant plant = plantService.getPlantById(idleId);
        model.addAttribute("idle", plant);
        return "idle_plant_exchange_apply";
    }

    // 🔥 最终修复：接收 plant_type！
    @RequestMapping("/exchangeApply")
    @ResponseBody
    public Map<String, Object> exchangeApply(
            @RequestParam("idleId") Integer idleId,
            @RequestParam String myPlantName,
            @RequestParam String myPlantDesc,
            @RequestParam String plant_type,
            @RequestParam(required = false) String myPlantImg,
            HttpSession session) {

        Map<String, Object> map = new HashMap<>();
        User user = (User) session.getAttribute("loginUser");
        if (user == null) {
            map.put("code", 500);
            map.put("msg", "请先登录");
            return map;
        }

        try {
            Plant myPlant = new Plant();
            myPlant.setPlant_name(myPlantName);
            myPlant.setPlant_type(plant_type);
            myPlant.setPlant_desc(myPlantDesc);
            myPlant.setCurrent_status("待交换");
            myPlant.setPlant_img(myPlantImg);

            plantService.addPlant(myPlant);

            AdoptApply apply = new AdoptApply();
            apply.setUser_id(user.getUser_id());
            apply.setPlant_id(idleId);
            apply.setStatus("待审核");
            adoptApplyService.saveApply(apply);

            map.put("code", 200);
            map.put("msg", "交换申请提交成功！等待管理员审核");

        } catch (Exception e) {
            e.printStackTrace();
            map.put("code", 500);
            map.put("msg", "提交失败：" + e.getMessage());
        }
        return map;
    }
}