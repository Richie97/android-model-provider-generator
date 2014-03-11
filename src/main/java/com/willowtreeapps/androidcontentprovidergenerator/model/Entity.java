/*
 * This source is part of the
 *      _____  ___   ____
 *  __ / / _ \/ _ | / __/___  _______ _
 * / // / , _/ __ |/ _/_/ _ \/ __/ _ `/
 * \___/_/|_/_/ |_/_/ (_)___/_/  \_, /
 *                              /___/
 * repository.
 * 
 * Copyright 2012 Benoit 'BoD' Lubek (BoD@JRAF.org).  All Rights Reserved.
 * 
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
package com.willowtreeapps.androidcontentprovidergenerator.model;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import org.apache.commons.lang.WordUtils;

public class Entity {
    private final String mName;
    private String url = "null";
    private final List<Field> mFields = new ArrayList<Field>();
    private final List<Constraint> mConstraints = new ArrayList<Constraint>();
    private final List<String> mQueryParams = new ArrayList<String>();

    public void setUrl(String url){
        this.url = url;
    }

    public String getUrl(){
        return this.url;
    }




    public Entity(String name) {
        mName = name.toLowerCase();
    }

    public void addField(Field field) {
        mFields.add(field);
    }

    public List<Field> getFields() {
        return Collections.unmodifiableList(mFields);
    }

    public List<String> getQueryParams(){return Collections.unmodifiableList(mQueryParams);}

    public void addQueryParam(String queryParam){mQueryParams.add(queryParam);}

    public void addConstraint(Constraint constraint) {
        mConstraints.add(constraint);
    }

    public List<Constraint> getConstraints() {
        return Collections.unmodifiableList(mConstraints);
    }

    public String getNameCamelCase() {
        return WordUtils.capitalizeFully(mName, new char[] { '_' }).replaceAll("_", "");
    }

    public String getNameLowerCase() {
        return mName;
    }

    public String getNameUpperCase() {
        return mName.toUpperCase();
    }

    @Override
    public String toString() {
        return "Entity [mName=" + mName + ", mFields=" + mFields + ", mConstraints=" + mConstraints + "]";
    }
}
