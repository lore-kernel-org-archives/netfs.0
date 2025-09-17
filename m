Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C979029BDBC
	for <netfs@lists.linux.dev>; Wed, 17 Sep 2025 20:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758140749; cv=none; b=i/v68EJexsD1OKpY3sv1l9NFKAyN7lSwhXXlk3qsKsEBzKuUsoH8ttMHAzbOD7vOdm9Gw9oTiDlMmADXcPja1WJElyGkd96PkLVGewbxaaNn7SRzhF4vjrQ0MfTwwhX3zjYxyVAnBbCfdpdGp+CBSn3+XeUcyfzgVkMMwQ5OSQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758140749; c=relaxed/simple;
	bh=K6d/jzhMMI4CPpQDgjpBmEl98KL3cG+euC4yxGzEVCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CPcVHBgUoRRymFmyFeXXPpCFl1/qz+1RmiGEwFOBYBrJyX5hWXptBu55AGBc2LjFh+XeH5qmz5tlCU3FGbBivgnv5qvu61dBRknGRCFbJE7zPpT4J4dVhzL9aIdLJvTe10hww98+FkcnydraUqiU2Ln/V8nTsoap89Qj7EDElPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=MPSExnwC; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="MPSExnwC"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b07d01fd4fbso33623666b.0
        for <netfs@lists.linux.dev>; Wed, 17 Sep 2025 13:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1758140746; x=1758745546; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RhNK71BU031VL7GqxBW1Krt0QEpivweMDtH+UA/VF5c=;
        b=MPSExnwCORHep4WoJEEmaGOZp4MaOz0EhzaYA9YEvogrvPNNT6ZDgz/Bjwww9YDtDA
         3h905ROracmr9LslgeqwuvhL721oD1IjJq+AAc22ZEAJW3Uj5SL2mYOfBJs7tW1m0EQM
         29+indJpMVCZWFMmtZBQum9jJZeGM0K2qAqc7VcnpbZqe45ZgK+rLaVhULftXAjJVlvq
         T3HFeG5N7mBCed01VQhXB7EYuYT5xDKg2E9m8Ns2j1FCsvVAjeXNJzkf0ebf5kobOVNF
         F1jCS+0olYWdvi84Y0/GitajZOSCXVr2x5pTCdK80+gVr6NTB/n5GjeEEA5oUQbqqvmT
         aQFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758140746; x=1758745546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RhNK71BU031VL7GqxBW1Krt0QEpivweMDtH+UA/VF5c=;
        b=ODbh0rRc2HsFyt3INdAWLAXIwXxkjUA6ke2fZF7ikACytFi+CY1KrC06C/kHyQos5d
         Ob/byOj2y8M2hTS1pSCuBZIxHyLiKVPmwQTBEd6Rnww6pUBzKDZ3bPSVmZVMffJhCTdM
         LiAC0QqfSU9KI0rDnYzzo619rvFSfjyQ5WUD0G4iHk/kdp2vmiVg+ts2LbnS7mwEqvQj
         tlovDeDcodhONrouozgpUCNyxAW9KHcAL5R5A9w2QNYEcFixiGBxUTdYrsZr6vIrcZqR
         0lGL/9+UyQQicDD6wyVfpdRmBwKGJX5CD7MVsCAfe91bDzQttfffr/3FVfJe69U36xiu
         OZJg==
X-Forwarded-Encrypted: i=1; AJvYcCX6u6yvtA3/qmBhfk/fnk1OOpJsya8hqHSxn4Q6tfZUCPJMhDroI+WkpQj4863RSzhG/CMjjg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyBeIAYYyvqdEcaLIEBOPFnv4VhtjvIAmaMcNMcjxvu/e5QNXUj
	WwcfONuj0Qq8A7jsJC+w3iTci52JjLJQkhPj7sVwGVXx+r1QiDafzr9Q7zfY/NDaDdN5Z9B9+lK
	Bl6GAr5sLPuUzUQ/dK4I4y6AZ3NJG2+JAssSnQG1pUQ==
X-Gm-Gg: ASbGncvWFVexsk+DHtlwGKkvekG6JqzbfZOBapq1Pu/u3ttWwsWOKEI3JgBmKcMYYNU
	Cv4v1sMdPd6dqwRPLzIGiNOsPHIzxUfKkIPqX6mi3ZsLg9gNrHuOtbhhxRjGDKb21FvdLo9tAoL
	1BtLyF49R2msywvd3JCyf6XQL3L0Zfx+ZXurQ15Uam/Z0UpcbxXnKATgFhs4ISG/cHuVE85PJTp
	aIukQ4C9SCyo8eEAS9ucoJ21ZECjmv4UsQQiiNXNskhC/XADCpexE/Co+CmJfvUww==
X-Google-Smtp-Source: AGHT+IFBvtsDmLFlrUPLrEdtXlj3XmnDOunMGaQVNwpHnx7V9K8cWA1KerJzVQIV4Og+xzCob2fZntJ3zIqyp+GB2lY=
X-Received: by 2002:a17:907:3e1f:b0:b04:2b28:223d with SMTP id
 a640c23a62f3a-b1bb6048f2cmr368398466b.20.1758140746182; Wed, 17 Sep 2025
 13:25:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250917135907.2218073-1-max.kellermann@ionos.com> <20250917202033.GY39973@ZenIV>
In-Reply-To: <20250917202033.GY39973@ZenIV>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Wed, 17 Sep 2025 22:25:35 +0200
X-Gm-Features: AS18NWA9lLP5Eqngelj0xlWoIoGVHH7XtsnclhYX2neNhHDUumPEaBrniNeVLQk
Message-ID: <CAKPOu+8eEQ6VjTHamxZRgdUM8E7z_yd3buK2jvCiG1m3k-x_0A@mail.gmail.com>
Subject: Re: [PATCH v2] ceph: fix deadlock bugs by making iput() calls asynchronous
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: slava.dubeyko@ibm.com, xiubli@redhat.com, idryomov@gmail.com, 
	amarkuze@redhat.com, ceph-devel@vger.kernel.org, netfs@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Mateusz Guzik <mjguzik@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 10:20=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> =
wrote:
>
> On Wed, Sep 17, 2025 at 03:59:07PM +0200, Max Kellermann wrote:
>
> > After advice from Mateusz Guzik, I decided to do the latter.  The
> > implementation is simple because it piggybacks on the existing
> > work_struct for ceph_queue_inode_work() - ceph_inode_work() calls
> > iput() at the end which means we can donate the last reference to it.
> >
> > This patch adds ceph_iput_async() and converts lots of iput() calls to
> > it - at least those that may come through writeback and the messenger.
>
> What would force those delayed calls through at fs shutdown time?

I was wondering the same a few days ago, but found no code to enforce
wait for work completion during shutdown - but since this was
pre-existing code, I thought somebody more clever than I must have
thought of this at some point and I just don't understand it. Or maybe
Ceph is already bugged and my patch just makes hitting the bug more
likely?
