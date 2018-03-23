
require('mobdebug').start()

waxClass{"ViewController"}

function viewDidLoad(self)
   self:ORIGviewDidLoad();
--self.super:viewDidLoad();
self:setTestColor();
--    self:view():setBackgroundColor(HTColor:colorWithHex(0x000000))

end

function setTestColor(self)
    self:view():setBackgroundColor(HTColor:colorWithHex(0xe3e300))
--    self:setTestColor();//如果要调用原来类中的方法要加上ORIG，否则会循环调用crash
--    self:ORIGsetTestColor();
end


