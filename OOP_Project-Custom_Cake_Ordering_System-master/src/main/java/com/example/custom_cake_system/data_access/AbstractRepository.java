package com.example.custom_cake_system.data_access;

import org.jooq.DSLContext;

/**
 * Abstract base class for repositories to share common DSLContext and utilities.
 * Demonstrates the OOP principle of Abstraction.
 */
public abstract class AbstractRepository {
    protected final DSLContext _context;

    protected AbstractRepository(DSLContext context) {
        this._context = context;
    }
}
