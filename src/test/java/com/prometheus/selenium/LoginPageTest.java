package com.prometheus.selenium;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.testng.Assert;
import org.testng.annotations.AfterClass;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.Test;

public class LoginPageTest {

    private WebDriver driver;

    @BeforeClass
    public void setUp() {
        var isHeadless = Boolean.valueOf(System.getProperty("headless"));
        ChromeOptions chromeOptions = new ChromeOptions();
        if (isHeadless) {
            chromeOptions.addArguments("--headless=new");
            chromeOptions.addArguments("--no-sandbox");
            chromeOptions.addArguments("--disable-dev-shm-usage");

        }
        this.driver = new ChromeDriver(chromeOptions);
        this.driver = new ChromeDriver();

    }

    @Test
    public void shouldOpenUrl() {
        this.driver.get("https://the-internet.herokuapp.com/login");

        this.driver.findElement(By.id("username")).sendKeys("tomsmith");
        this.driver.findElement(By.id("password")).sendKeys("SuperSecretPassword!");
        this.driver.findElement(By.cssSelector("[type='submit']")).click();
        Assert.assertEquals("Secure Area", this.driver.findElement(By.tagName("h2")).getText(), "Asserting header of the page");
    }



    @AfterClass
    public void tearDown() {
        this.driver.close();

    }

}
