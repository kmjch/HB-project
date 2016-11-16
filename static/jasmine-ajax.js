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

            xhr.open("GET", "/search.json");
            xhr.send();

            expect(jasmine.Ajax.requests.mostRecent().url).toBe('/search.json');
            // assert that "loading the best restaurants for you..." is showing
            expect(doneFn).not.toHaveBeenCalled();

            jasmine.Ajax.requests.mostRecent().response({
                'status': 200,
                'contentType': 'text/plain',
                'responseText': 'replace this response'
            });

            expect(doneFn).toHaveBeenCalledWith('replace this response');
        });
    });
});