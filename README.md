# tower_homework
Homework test for applying a job for Colorway

应聘彩程设计的后端测试题

## Install

```
bundle install
rails db:migrate
# 生成展示数据
rails db:seed
rspec
rails server
```

## Sample

登录 /sign_in 页面，输入以下任一用户名，会进入首页。

```
ifournight
moerlang_cat
ifournighthk
```

点击团队，会进入团队页面，可以创建，完成，重新打开任务

点击顶部header的"动态"，进入动态页面

## 完成内容

* 按照要求：设计动态Activity 模型，考虑到了扩展性，动态数据，不同展示内容的需求。
* 按照要求：完成了动态流页面。
* 按照要求：完成了基本模型的设计
* RSpec测试尽可能的cover到了model/ services/ requests/ features
* 权限系统的设计
* 业务逻辑：创建团队／将用户加入团队 / 新建团队/ 所有的任务相关业务
* 一些Sample Controller/View为作品展示服务：登录／团队页面／项目页面／创建和完成 任务

## 介绍

以下操作会产生动态：

* 创建任务
* 完成任务
* 重新打开任务
* 指派任务完成者
* 设置任务截止日期

重现tower的用户权限设计，登录后，用户只会看到所在团队中，自己已经加入的项目。


同样的：在动态页面里，也只会看到当前团队，自已已经加入的项目的动态。


> 举例：示例数据中一共创建了2个team，分别两个project，如果你使用`moerlang_cat`这个用户登录，会发现首页里只看到的3个项目，因为这个用户只加入了这三个项目。


## 核心设计理念

### 动态流

扩展性：
* 利用多态关联: Activity的subject可以是任一Model
* Activity有一个列属性extra，用来serialize一些额外的动态相关信息

不同展示内容：
* 用"activity_#{activity_action}"来动态合成partial名称，动态地渲染不同种类的Activity视图

### 权限

Access也使用到了多态关联，可以理解为某用户对于某个subject有哪些权限？可以是有关Team的access，可以是有关project的access。

一个用户实际上是有众多的权限列表。比如对于团队A有哪些权限，对于团队A中的项目分别有哪些权限。把众多权限列表分组，批量的创建／删除，就实现了所谓的团队里的`超级管理员`，`管理员`， `普通成员`, `访客`。

这样设计的目的也是为了更好的扩展性，可以实现：

* 团队超级管理员可以自定义一个权限组，然后将对应的团队成员加入权限组
* 可以方便的进行设置
* 实现访客功能


## 测试原则

Model Test: 应该尽可能完全覆盖

Service Test: services作为实际业务的执行者，应尽可能完全覆盖

Controller Test: 因为activities#index实际上只是取得了一些筛选条件下的Activity数据，逻辑和业务交互有限，个人认为不用花重点去测试，其他controller
* 动态流页面尽可能在feature test中去体现和验证
* api controller应该写request test
* sample的controller因为时间有限，就不写test
了

Request Test: 我在作业要求之外实现了CreateTeam/ CreateTodo/ CompleteTodo api的简单设计，需要测试

Feature Test: 需要尽可能覆盖
