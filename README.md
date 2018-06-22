> 示例项目地址： https://github.com/14251104246/flyway-demo
> [flyway工作原理]（https://flywaydb.org/getstarted/how）
## 简单使用（集成 spring boot 直接看下面）
#### 配置
- 添加依赖
```xml
<dependency>
    <groupId>org.flywaydb</groupId>
    <artifactId>flyway-core</artifactId>
    <version>5.1.1</version>
</dependency>
```
- 如下添加sql脚本
>  ![image.png](https://upload-images.jianshu.io/upload_images/7176877-d6c854c795141deb.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
#### 运行
- 代码如下
```
public class TestFlyway {
    @Test
    public void flyway(){
        // Create the Flyway instance
        Flyway flyway = new Flyway();

        // Point it to the database
        flyway.setDataSource("jdbc:mysql://127.0.0.1:3306/flyway?useLegacyDatetimeCode=false&serverTimezone=Asia/Hong_Kong&useSSL=false", "root", "123456");

        // Start the migration
        flyway.migrate();
    }
}
```
- 运行单元测试
- 可以看到数据库多了两个表（`flyway_schema_history`是flyway用于存储版本记录信息，`users`是我们的脚本建的）
> ![image.png](https://upload-images.jianshu.io/upload_images/7176877-07764e4ac8fd45d8.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## spring boot 项目集成flyway
> 这里使用的数据库是一样的，所以集成spring boot后flyway仍然能知道数据库的版本记录
#### 配置
- 添加依赖
```xml
<dependency>
    <groupId>org.flywaydb</groupId>
    <artifactId>flyway-core</artifactId>
    <version>5.1.1</version>
</dependency>
```
- 添加配置（[配置参数解析](https://flywaydb.org/documentation/commandline/migrate)）
```
# 数据库版本控制
flyway:
  enabled: true
  baseline-on-migrate: true
  # 是否开启校验
  validate-on-migrate: false
  # 默认脚本加载路径：/db/migration
# locations=classpath:/db/migration
```
- 如下添加新版本的sql脚本（红框部分是版本号，flyway这时只会执行V1.3版本的脚本）
>  ![image.png](https://upload-images.jianshu.io/upload_images/7176877-42e65a3c4685bcd5.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
#### 运行
- 启动 spring boot 项目，flyway会自动初始化数据库
- 相关日志输出如下
```
2018-06-20 11:12:40.791  INFO 19067 --- [  restartedMain] o.f.core.internal.util.VersionPrinter    : Flyway Community Edition 5.1.1 by Boxfuse
2018-06-20 11:12:40.955  INFO 19067 --- [  restartedMain] o.f.c.internal.database.DatabaseFactory  : Database: jdbc:mysql://127.0.0.1:3306/flyway (MySQL 5.7)
2018-06-20 11:12:40.990  INFO 19067 --- [  restartedMain] o.f.core.internal.command.DbMigrate      : Current version of schema `flyway`: 1.2
2018-06-20 11:12:40.996  INFO 19067 --- [  restartedMain] o.f.core.internal.command.DbMigrate      : Migrating schema `flyway` to version 1.3 - InsertUserAndCreateOrder
2018-06-20 11:12:41.020  INFO 19067 --- [  restartedMain] o.f.core.internal.command.DbMigrate      : Successfully applied 1 migration to schema `flyway` (execution time 00:00.041s)
2018-06-20 11:12:41.140  INFO 19067 --- [  restartedMain] o.s.b.d.a.OptionalLiveReloadServer       : LiveReload server is running on port 35729
2018-06-20 11:12:41.239  INFO 19067 --- [  restartedMain] o.s.j.e.a.AnnotationMBeanExporter        : Registering beans for JMX exposure on startup
2018-06-20 11:12:41.264  INFO 19067 --- [  restartedMain] s.b.c.e.t.TomcatEmbeddedServletContainer : Tomcat started on port(s): 18080 (http)
2018-06-20 11:12:41.267  INFO 19067 --- [  restartedMain] com.neo.Application                      : Started Application in 2.636 seconds (JVM running for 3.202)

```
- 数据库成功插入数据并创建新的表
> ![image.png](https://upload-images.jianshu.io/upload_images/7176877-5f3d298453b0206c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
    