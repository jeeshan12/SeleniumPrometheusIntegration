package com.prometheus.selenium;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.testng.Assert;
import org.testng.annotations.AfterClass;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.Test;

public class NavigateToURLTest {


    private WebDriver driver;

    @BeforeClass
    public void setUp() {
        var isHeadless = Boolean.valueOf(System.getProperty("headless"));
        ChromeOptions chromeOptions = new ChromeOptions();
        if (isHeadless) {
            chromeOptions.addArguments("--headless=new");

        }
        this.driver = new ChromeDriver(chromeOptions);

    }

    @Test
    public void shouldOpenUrl() {
        this.driver.get("https://the-internet.herokuapp.com/");
        Assert.assertEquals("Welcome to the-internet", this.driver.findElement(By.tagName("h1")).getText(), "Asserting header of the page");
    }



    @AfterClass
    public void tearDown() {
        this.driver.close();

    }

}
