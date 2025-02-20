Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0561F7914
	for <netfs@lists.linux.dev>; Thu, 20 Feb 2025 13:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740056973; cv=none; b=LWQjYQXjn7Zm73qxbp5g8imF/FXQr5xRIcjpygCu6jXx3MXCjqgMkeO6O6LcQVP/iafKtyYWPjCodcyozFUb5QTe1mOqlVJ0G8LE9GTyuiVRj+mFQgKBlAVFuQ+16Z+ZQXtZZI0bkoc63JDqmtfEqw+/fWE4MJO9BOguYT2jhiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740056973; c=relaxed/simple;
	bh=659Z5MgEmFp3Njkp+0t+ptDcYZt275fHIOylgA3dWnI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pIYpKqaayCVUXwDgzAMYgSJewv30k3c3Mt94alY2Gk4oGCecFhSmtqSkIQuI04qUB85SUJVpzzb8d3qczxuHycdtRPNK44DZqwgBqwybPLknxJzepR3wKy2Oc6nWw2wKJh3VWvnTWntqx3YNIkNYEx71Q3cRu2GmVXhuejN2ePI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=LHJKlwUN; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="LHJKlwUN"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e0452f859cso1398212a12.2
        for <netfs@lists.linux.dev>; Thu, 20 Feb 2025 05:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1740056970; x=1740661770; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=659Z5MgEmFp3Njkp+0t+ptDcYZt275fHIOylgA3dWnI=;
        b=LHJKlwUNKwG8SHk082Zeo74fmVMczmi3ceDifIievhbpR6uXXCV59U682Rx3KUwQ1G
         E/GMLw+1AIhM1vZm0AnhQ6xKWQpCnQp9Lp3Rd3qM4Gw0mAbf/2UG5L8iJhZK/tC5LxpH
         ah3MexNVp7XeFi5JAAcfEFWBRjnxE8F9qkKW7fCFqKVF4I3tJGduUVIMgmtBf4Zo8QBg
         3SwxSvEscOqsGTPq2JIkSGxmKCKucP3yQyO+Pqng4jc/bXBxrFHlze0YcZ0PK9R0RfW+
         ctYWbQ1XKRc6eMR+oWN2GS8IUEhkRnH+7Rs5+gOc1VJp0W9TZCJRAgpogRRczBbRzsn5
         Bd8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740056970; x=1740661770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=659Z5MgEmFp3Njkp+0t+ptDcYZt275fHIOylgA3dWnI=;
        b=hBb86QFwVkXtFTx+u6v4NZvvBYJWsgf3BcU3scjj71RoE97tL25i4mHQJYNKnBqgqE
         VDCnQS002hB5SMWs9NAuDdNQxcxV3oAeqf8BmDQXTQAgsKYDr0SBLfCfFnlqM6W4JM1N
         EMHRfI6hqSXNXD7B0t8dFZ447OkVRn+fikz9jfdvQ9b1IHZ8ne4HC9Mw2mR6mmsfrE3h
         4kh7vgr+/cieAVm9EZ9MFUUmfJke/NaBShRck72/uP/iIl/f68cOXnVoJ6BkhbpwCYHG
         H/Fwkbxt1ayACh6j9Ozj9eUgyq2rMZ7pp8csWJQW7KnMJR20FY9udJGcl9LeoYAGQsBE
         V5mw==
X-Gm-Message-State: AOJu0YxhAThdaIdIzp0BzUXQ40hlCtw2XvVQNYfGokU/AkHiqM5Rzkc9
	4AnR4xmwh5dlNoRt9/D5pl/99+kj49HoTtCVtK5nC/C18p6NpYl+g6Pk+0pFqHNalwXjhoyVB8y
	8MDxEnDOPhdMDqEN74QfTNUgD9VuXKhfegwJnWQ==
X-Gm-Gg: ASbGncu8dJxVZ9iH64KzQOacAVhlp3xcKu32l9/EyiP2Ty6oe0DC2Zk8WA5dpTYX66A
	IwAWpeQ5wySBTVSLu484RLKxgeNGyvssMt9a92zKLw5gCDbONegRTvRJ+eRq1PMfd1y+A+Fvk9M
	91cBY2NYp8S2oHh1VRWoVVPlo0HA==
X-Google-Smtp-Source: AGHT+IGPoX+5794U07EydT48UEKhGOyMUOF2FtzKyULbqoGRP0V32LcSKq9unFMC783mM102XE9wLcWd7UMwvlaZCoY=
X-Received: by 2002:a17:906:dc90:b0:ab7:86af:9e19 with SMTP id
 a640c23a62f3a-abbcd05a611mr799771966b.43.1740056969659; Thu, 20 Feb 2025
 05:09:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAKPOu+_4mUwYgQtRTbXCmi+-k3PGvLysnPadkmHOyB7Gz0iSMA@mail.gmail.com>
 <20250210191118.3444416-1-max.kellermann@ionos.com> <3978045.1739537266@warthog.procyon.org.uk>
In-Reply-To: <3978045.1739537266@warthog.procyon.org.uk>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Thu, 20 Feb 2025 14:09:17 +0100
X-Gm-Features: AWEUYZmpP9P0Gfh3rezBjkEnKqpCWeO7xkkWonrM0Uq7UsX6pZI6C3FwpwtpoBk
Message-ID: <CAKPOu+8cD=HkoNYYknivDJnb6Pfxv+KF28SBUDEqha4NE5sxhg@mail.gmail.com>
Subject: Re: [PATCH] fs/netfs/read_collect: add to next->prev_donated
To: David Howells <dhowells@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: netfs@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 1:47=E2=80=AFPM David Howells <dhowells@redhat.com>=
 wrote:
> Signed-off-by: David Howells <dhowells@redhat.com>

Greg, you merged my other two netfs fixes into 6.13.3, but omitted
this one. Did you miss it, or was there another reason?
