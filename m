Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FF918E754
	for <netfs@lists.linux.dev>; Mon,  9 Sep 2024 23:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725926102; cv=none; b=M+6EL+CN1gglTSmz8s2A3P/GdJNYkxwOuHpvi20qlWSNc55ezdERQ2I7jDGOPJltW1mNi/KZ+CXjww1MDJ4eDaRKShH6TsX6wamegoDE7o5CEauHyd0qu64tqPwqPmOsbi+eMaMe9/D7L3HMrOd1Fyv2P3OcpGjAN6O84N4eHnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725926102; c=relaxed/simple;
	bh=M1KoFSpNUOLVXT1kP5VICXcC5Vs8wFtp9teskKlY70s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 Cc:Content-Type; b=jHdrLfatHS2EnrVSW1aOxh7Vi/JFR5Y1b1bg7UvYxAc+iWnfDG+U7vNLk0bwUH6RSgt3+Bdfo4N97PtYrnrMRppv+JhD9RtJrs6v3uoKS9gWzTCzdpjWnqUAp3xbWI0ABIKiLalfPDHWPQygld1DXyHa0SGan8ey90A2TLorouw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XZf/jN56; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZf/jN56"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-846bc787856so1133262241.0
        for <netfs@lists.linux.dev>; Mon, 09 Sep 2024 16:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725926100; x=1726530900; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AxX5C1PVQFhcpEMOTxZjcoasZZvFqrJMsr5iTanZpSY=;
        b=XZf/jN56c1y5PLl4Hsm+astbA5JzZ++vwlE9nfyXwRDvENZIyhxrwRg8VvUaWU7Sp0
         w6AYeb5Lsk97QoJQaE9kDehvIfFhwi4S7kC9eEu26LQ25I0aMoeUurpoHQRgGctddYcS
         kRSdlBDtt/w2JOlS9X14QZ02Ka1u9mEo0HBd4PM1z55Lcp2i5ePC+Zopczg6SQYmWBxs
         lTU2xyQHItoGnGk9kmzjTV8xff0jOV3pNIu+36LAPF3Ys7rL66TIBhfHc9VNMJmY3CBp
         vnW/c3cPn4BWFfsKRR69yZCDkcUFrVbCJW44AZGRJYD9m07oRmxl33PsPHndkMmP1b0e
         ZJ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725926100; x=1726530900;
        h=content-transfer-encoding:cc:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AxX5C1PVQFhcpEMOTxZjcoasZZvFqrJMsr5iTanZpSY=;
        b=ars1xFvTccii01J4O1wSFcTjZ0/5qC6TN/VGnHHSTiC9JSDRORgskQnJ9FSpYg4Fr0
         7rZetY4vBT6S+poB6sai3v+ZQcFb+CPgDx+wpyce6yARB+0sS8MSSUZSX05DluJVAdEd
         J7s5urXODIaWtfXvgfhuzby3XzyvHp1a4+IlzMtDPD436DZMTH2MoTkDw9LVRGgk3Sx0
         4u7583PdYMyYhNeMJyJ8crKaKAaSr0v3wLIy/ewbhz8YyqclnChgLNZn+ca+KLAmefgj
         bjqKG0fN0Hu0UF52jMIknw/ghii/+iq9FPKx0sMXcRaluqmrPC8CWUyruVu7G1fzKkJg
         UMxA==
X-Gm-Message-State: AOJu0YzWESIfUejGQ6g/19QqmmjVLhUPnNdtl28SOoUEL9904i7zbElz
	LS4k/SuCODCnApF+6JGgLhvZc6qP2yvT0GR/imWFQZhsVrwIbF1mp6n857oBewiw3c0ZTtbO1XA
	baE89aOY+xtjC/YuIsd08SQNdfHX8H4eWurU=
X-Received: by 2002:a05:6122:2a54:b0:501:1895:203a with SMTP id
 71dfb90a1353d-502142032f9mt15753355e0c.7.1725926100090; Mon, 09 Sep 2024
 16:55:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240908192307.20733-3-dennis.lamerice@gmail.com> <346199.1725873065@warthog.procyon.org.uk>
In-Reply-To: <346199.1725873065@warthog.procyon.org.uk>
From: Dennis Lam <dennis.lamerice@gmail.com>
Date: Mon, 9 Sep 2024 19:54:49 -0400
Message-ID: <CAGZfcdkGw55MKTYxuOkCgu8kJU86jkERfLRJAP+J8Z6=0z1F+g@mail.gmail.com>
Subject: Re: [PATCH] docs:filesystems: fix spelling and grammar mistakes on
 netfs library page
Cc: netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the feedback. I'll be sure to revert the "fulfil" change
and correct the pluralization in a new patch.

Dennis

On Mon, Sep 9, 2024 at 5:11=E2=80=AFAM David Howells <dhowells@redhat.com> =
wrote:
>
> Dennis Lam <dennis.lamerice@gmail.com> wrote:
>
> > - * Allow the netfs to partially fulfil a read, which will then be resu=
bmitted.
> > + * Allow the netfs to partially fulfill a read, which will then be res=
ubmitted.
>
> "fulfil" is also correct:
>
>         https://en.wiktionary.org/wiki/fulfil
>
> > - * Handle clearing of bufferage that aren't on the server.
> > + * Handle clearing of bufferages that aren't on the server.
>
> "bufferage" wouldn't be countable and can't be pluralised, so the fix sho=
uld
> be "aren't" -> "isn't" instead.
>
> David
>
