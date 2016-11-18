function setUp() {
    $('body').append($('<input type="datetime-local" id="time" name="time">'));
}

describe("My Test Suite", function () {

    it("should add numbers", function () {
        var sum = adder(2, 3);
        expect(sum).toBe(5);
    });

    it("should add negative numbers", function () {
        expect(adder(100, -1)).toBe(99);
    });


    it("test showTimeField", function() {
        setUp();
        showTimeField({'target':{'value': 'now'}});
        // console.log($('#time').css("display"));
        expect($('#time').css("display")).toBe('none');
        showTimeField({'target':{'value': 'later'}});
        expect($('#time').css("display")).not.toBe('none');
    });

});

describe("mocking ajax", function() {
    describe("suite wide usage", function() {
        beforeEach(function() {
            jasmine.Ajax.install();
        });
        afterEach(function() {
            jasmine.Ajax.uninstall();
        });
        it("specifying response when you need it", function() {
            var doneFn = jasmine.createSpy("success");

            var xhr = new XMLHttpRequest();
            xhr.onreadystatechange = function(args) {
                if (this.readyState == this.DONE) {
                    doneFn(this.responseText);
                }
            };

            xhr.open("GET", "")
        })
    })
})