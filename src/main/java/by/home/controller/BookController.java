package by.home.controller;

import by.home.model.Book;
import by.home.service.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.validation.Valid;
import java.util.concurrent.atomic.AtomicInteger;

@Controller
public class BookController {
    private BookService service;

    @Autowired
    @Qualifier(value = "bookService")
    public void setService(BookService service) {
        this.service = service;
    }

    @RequestMapping(value = "books", method = RequestMethod.GET)
    public String listBooks(Model model) {
        model.addAttribute("book", new Book());
        model.addAttribute("listBooks", this.service.listBooks());
        return "books";
    }

    @RequestMapping(value = "books/add", method = RequestMethod.POST)
    public String addBook(@Valid @ModelAttribute("book") Book book, BindingResult result) {
        if (result.hasErrors()) {
            return "books";
        }
        if (book.getId() == 0) {
            this.service.addBook(book);
        } else {
            this.service.updateBook(book);
        }
        return "redirect:/books";
    }

    @RequestMapping(value = "remove/{id}")
    public String removeById(@PathVariable("id") int id) {
        this.service.removeBook(id);
        return "redirect:/books";
    }

    @RequestMapping(value = "edit/{id}")
    public String editBook(@PathVariable("id") int id, Model model) {
        model.addAttribute("book", this.service.getBookById(id));
        model.addAttribute("listBooks", this.service.listBooks());
        return "books";
    }

    @RequestMapping(value = "bookdata/{id}")
    public String showBookData(@PathVariable("id") int id, Model model) {
        model.addAttribute("book", this.service.getBookById(id));
        return "bookdata";
    }

}
